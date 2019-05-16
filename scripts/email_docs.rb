require 'sendgrid-ruby'
require 'base64'
include SendGrid
DOC_LOCATION = 'doc/Raining.epub'.freeze
email_address = Base64.decode64("Y2hhc2UuZ2lsbGlhbUBnbWFpbC5jb20=\n")
content = SendGrid::Content.new(type: 'text/plain', value: 'Docs for Raining App')
from = Email.new(email: email_address)
to = Email.new(email: email_address)
subject = 'See Attachment For Raining Docs'
mail = SendGrid::Mail.new(from, subject, to, content)
attachment = Attachment.new
attachment.content = Base64.strict_encode64(File.open(DOC_LOCATION, 'rb').read)
attachment.type = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
attachment.filename = 'Raining.epub'
attachment.disposition = 'attachment'
attachment.content_id = 'Reports Sheet'
mail.add_attachment(attachment)
personalization = Personalization.new
personalization.add_to(Email.new(email: email_address))
mail.add_personalization(personalization)

sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
begin
  response = sg.client.mail._('send').post(request_body: mail.to_json)
rescue Exception => e
  puts e.message
end

puts response
