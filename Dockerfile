FROM ubuntu

RUN apt-get update && apt-get install -yq libgconf-2-4

RUN apt-get update \
    && apt-get -y install curl gnupg \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sL https://deb.nodesource.com/setup_11.x  | bash - \
    && apt-get -y install nodejs

RUN apt-get update \
    && apt-get install chromium-browser -y

RUN npm install puppeteer
# RUN apt-get update && apt-get install -y wget --no-install-recommends \
#     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#     && apt-get update \
#     && apt-get install -y google-chrome-unstable \
#       --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get purge --auto-remove -y curl \
#     && rm -rf /src/*.deb
WORKDIR /grading-utils
COPY . /grading-utils
COPY package.json /grading-utils
RUN npm install

# RUN npm i puppeteer
RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && chown -R pptruser:pptruser /grading-utils 
    # && chown -R pptruser:pptruser ./node_modules
USER pptruser
COPY /bin/$checker /bin/$checker
COPY /bin/${reference_image} /bin/
CMD chmod +x /bin/$checker
ENTRYPOINT ./bin/${checker}





