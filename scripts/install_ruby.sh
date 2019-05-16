echo "Installing Rbenv/Ruby Required Packages"
sudo apt-get update 
sudo apt install git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

echo "Installing Rbenv"

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

echo "Installing Ruby"
rbenv install 2.5.1
rbenv global 2.5.1
ruby -v
sudo apt-get install rubygems
echo "Installing SendGrid"
gem install sendgrid-ruby

exit 0
