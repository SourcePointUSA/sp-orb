#!/bin/bash
echo 'export SLACK_MESSAGE_HEADER="${PARAM_MESSAGE_HEADER}"' >> $BASH_ENV
echo 'export SLACK_GIT_URL="${PARAM_GIT_URL}"' >> $BASH_ENV
if [ "${PARAM_LINK_TO_WORKFLOW}" = "true" ]
then
  echo 'export CIRCLE_CI_ACTION_LINK="${PARAM_CIRCLE_CI_HOST}/workflow-run/${PARAM_WORKFLOW_ID}"' >> $BASH_ENV
else
  echo 'export CIRCLE_CI_ACTION_LINK="${PARAM_BUILD_URL}"' >> $BASH_ENV
fi