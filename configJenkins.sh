#!/bin/bash

{
cat > config.xml <<EOF
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@2.4.0">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>$GIT_TESTS_URL</url>
        <credentialsId>60392a8f-e667-4381-bed7-77e5f757cc28</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
      <hudson.plugins.git.UserRemoteConfig>
        <url>$GIT_LABS_URL</url>
        <credentialsId>030b8d3b-8dcb-4c13-ae16-ca8dd7b228a2</credentialsId>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>$BRANCH_SPECIFIER</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <browser class="hudson.plugins.git.browser.AssemblaWeb">
      <url></url>
    </browser>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <com.cloudbees.jenkins.GitHubPushTrigger plugin="github@1.14.0">
      <spec></spec>
    </com.cloudbees.jenkins.GitHubPushTrigger>
    <org.jenkinsci.plugins.gitlab.GitlabBuildTrigger plugin="gitlab-merge-request-jenkins@1.2.4">
      <spec>$CRONTAB_LINE</spec>
      <__cron>$CRONTAB_LINE</__cron>
      <__projectPath>$GITLAB_PROJECT_PATH</__projectPath>
      <__targetBranchRegex>$TARGET_BRANCH_REGEX</__targetBranchRegex>
      <__useHttpUrl>false</__useHttpUrl>
      <__assigneeFilter></__assigneeFilter>
      <__triggerComment></__triggerComment>
      <__autoCloseFailed>$AUTO_ClOSE_FAILED</__autoCloseFailed>
      <__autoMergePassed>$AUTO_MERGE_PASSED</__autoMergePassed>
    </org.jenkinsci.plugins.gitlab.GitlabBuildTrigger>
    <hudson.triggers.SCMTrigger>
      <spec>$SCM_SCHEDULE</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>$EXECUTE_SHELL_COMMAND</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.plugins.emailext.ExtendedEmailPublisher plugin="email-ext@2.41.3">
      <recipientList>$RECIPIENT_LIST</recipientList>
      <configuredTriggers>
        <hudson.plugins.emailext.plugins.trigger.FailureTrigger>
          <email>
            <recipientList></recipientList>
            <subject>$PROJECT_DEFAULT_SUBJECT</subject>
            <body>$PROJECT_DEFAULT_CONTENT</body>
            <recipientProviders>
              <hudson.plugins.emailext.plugins.recipients.DevelopersRecipientProvider/>
            </recipientProviders>
            <attachmentsPattern></attachmentsPattern>
            <attachBuildLog>$ATTACH_BUILD_LOG</attachBuildLog>
            <compressBuildLog>false</compressBuildLog>
            <replyTo>$PROJECT_DEFAULT_REPLYTO</replyTo>
            <contentType>project</contentType>
          </email>
        </hudson.plugins.emailext.plugins.trigger.FailureTrigger>
      </configuredTriggers>
      <contentType>text/html</contentType>
      <defaultSubject>$DEFAULT_SUBJECT</defaultSubject>
      <defaultContent>${FILE,path=&quot;results.html&quot;}</defaultContent>
      <attachmentsPattern></attachmentsPattern>
      <presendScript>$DEFAULT_PRESEND_SCRIPT</presendScript>
      <attachBuildLog>true</attachBuildLog>
      <compressBuildLog>false</compressBuildLog>
      <replyTo>$DEFAULT_REPLYTO</replyTo>
      <saveOutput>false</saveOutput>
      <disabled>false</disabled>
    </hudson.plugins.emailext.ExtendedEmailPublisher>
  </publishers>
  <buildWrappers/>
</project>
EOF
} | sh

curl -X POST -H "Content-Type:application/xml" -d "<project><builders/><publishers/><buildWrappers/></project>" "http://localhost:8080/createItem?name=CppCourceTesting_Sem3" 

curl -X POST http://localhost:8080/job/CppCourceTesting_Sem3/config.xml --data-binary "@config.xml"

sleep 20 

# jenkins safe restart
curl -X POST $host/safeRestart

