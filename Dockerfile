FROM ubuntu
MAINTAINER mentors


# ENV output_dir="/webdev/home/Documents"
# ENV TMPDIR="/webdev/home/Documents"
# ENV branch="master"
# ENV repo="https://github.com/ogbry/grading-utils"
# ENV reference_image=""

ADD . /grading-utils
ADD /bin/grade_html_css_final.sh /bin/grade_html_css_final.sh
#ADD /bin/grade_jasmine_spec_repo.sh /bin/grade_jasmine_spec_repo.sh
ADD package.json /grading-utils
WORKDIR /grading-utils
RUN apt-get update
RUN apt-get -y install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
RUN npm install
WORKDIR /grading-utils/bin
RUN chmod +x grade_html_css_final.sh
#RUN chmod +x grade_jasmine_spec_repo.sh

ENTRYPOINT [ "./grade_html_css_final.sh" ] 







