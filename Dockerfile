FROM ubuntu

RUN apt-get update && apt-get install -yq libgconf-2-4

RUN apt-get -y install curl gnupg \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && curl -sL https://deb.nodesource.com/setup_11.x  | bash - \
    && apt-get -y install nodejs

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /grading-utils
COPY . /grading-utils
COPY package.json /grading-utils
RUN pwd
RUN npm install
RUN npm install puppeteer-core chrome-aws-lambda --save-prod
RUN npm install puppeteer --save-dev

# RUN apt-get -y install xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
#       libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
#       libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
#       libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
#       libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget && \
#     rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get install -y wget --no-install-recommends \
#     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#     && apt-get update \
#     && apt-get install -y google-chrome-unstable \
#       --no-install-recommends \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get purge --auto-remove -y curl \
#     && rm -rf /src/*.deb

# WORKDIR /grading-utils
# COPY . /grading-utils
# COPY package.json /grading-utils
# RUN npm install

# RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
#     && chown -R pptruser:pptruser /grading-utils 
#     # && chown -R pptruser:pptruser ./node_modules
# USER pptruser

COPY /bin/grade_html_css_final.sh /bin/grade_html_css_final.sh
COPY ${reference_image} .
CMD chmod +x bin/grade_html_css_final.sh

ENTRYPOINT ./bin/grade_html_css_final.sh





