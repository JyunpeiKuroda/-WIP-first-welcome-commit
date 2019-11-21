# ruby:2.6.3のDockerイメージをベースとして利用
FROM ruby:2.6.3

# 必要なパッケージのインストール
RUN apt-get update && apt-get install -y build-essential libpq-dev nodejs

# yarnパッケージ管理ツールをインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

# 作業ディレクトリの作成、設定
RUN mkdir /personal_app

# 作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /personal_app
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加する
COPY ./Gemfile $APP_ROOT/Gemfile
COPY ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
COPY . $
