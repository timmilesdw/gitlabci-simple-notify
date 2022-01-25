#!/usr/bin/env sh

SILENT = 0

if [["$2" == "silent"]]; then
   SILENT = 1
fi

TIME="10"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Starting pipeline: %0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG%0ATag:+$CI_COMMIT_TAG%0ACommit:$CI_COMMIT_SHORT_SHA"


if [[ "$1" == "end" ]]; then
    TEXT="Pipeline status: $3%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG%0ATag:+$CI_COMMIT_TAG%0ACommit:$CI_COMMIT_SHORT_SHA"
fi

curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT&silent=$SILENT" $URL > /dev/null
