FROM node

WORKDIR /grading-utils
COPY package.json /grading-utils
RUN npm install
RUN cd grading-utils/bin
RUN sudo chmod +x grade_html_css_final.sh
RUN ./grade_html_css_final







