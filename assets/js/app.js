// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css"
import LiveSocket from "phoenix_live_view"
// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

window.LiveSocket = new LiveSocket("/live")
window.LiveSocket.connect()

window.onload = () => {
  navigator.geolocation.watchPosition(function (position) {
    window.LiveSocket.pushLiveEvent('weather', 'set_lat_lon', {
      lat: position.coords.latitude,
      lon: position.coords.longitude
    })
  })
}

window.addEventListener('hashchange', function () {
  window.LiveSocket.pushLiveEvent('nav', 'hashchange', window.location.hash.substring(1))
})

window.LiveSocket.pushLiveEvent = function (query, event, value) {
  const view = window.LiveSocket.views[document.getElementById(query).parentElement.id]

  view.channel.push('event', {
    event: event,
    type: null,
    value: value
  }, 20000).receive("ok", diff => {
    view.update(diff)
  })
}