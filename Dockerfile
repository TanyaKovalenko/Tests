FROM jenkins:latest

USER root
RUN apt-get update && apt-get install -y --no-install-recommends sudo sed git openssh-client unzip wget curl zip xsltproc cppcheck make g++ valgrind jq && rm -rf /var/lib/apt/lists/*
#ENV JENKINS_UC_DOWNLOAD http://updates.jenkins-ci.org/download
#ENV JENKINS_UC http://updates.jenkins-ci.org
#COPY plugins.txt /usr/share/jenkins/ref/
#COPY plugins.sh /usr/local/bin/plugins.sh
#RUN chmod 755 /usr/local/bin/plugins.sh
#RUN /usr/local/bin/plugins.sh /usr/share/jenkins/ref/plugins.txt
COPY github-oauth.jpi /usr/share/jenkins/ref/plugins/github-oauth.jpi
COPY plain-credentials.jpi /usr/share/jenkins/ref/plugins/plain-credentials.jpi
COPY git-client.jpi /usr/share/jenkins/ref/plugins/git-client.jpi
COPY token-macro.jpi /usr/share/jenkins/ref/plugins/token-macro.jpi
COPY email-ext.jpi /usr/share/jenkins/ref/plugins/email-ext.jpi
COPY mailer.jpi /usr/share/jenkins/ref/plugins/mailer.jpi
COPY gitlab-merge-request-jenkins.jpi /usr/share/jenkins/ref/plugins/gitlab-merge-request-jenkins.jpi
COPY scm-api.jpi /usr/share/jenkins/ref/plugins/scm-api.jpi
COPY git.jpi /usr/share/jenkins/ref/plugins/git.jpi
COPY github-api.jpi /usr/share/jenkins/ref/plugins/github-api.jpi
COPY github.jpi /usr/share/jenkins/ref/plugins/github.jpi
COPY hudson.plugins.emailext.ExtendedEmailPublisher.xml /var/jenkins_home/hudson.plugins.emailext.ExtendedEmailPublisher.xml
COPY org.jenkinsci.plugins.gitlab.GitlabBuildTrigger.xml /var/jenkins_home/org.jenkinsci.plugins.gitlab.GitlabBuildTrigger.xml
COPY hudson.tasks.Mailer.xml /var/jenkins_home/hudson.tasks.Mailer.xml
COPY hudson.scm.CVSSCM.xml /var/jenkins_home/hudson.scm.CVSSCM.xml
