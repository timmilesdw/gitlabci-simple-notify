#!/usr/bin/env sh

if [[ "$1" == "end" ]]; then
    TIME="10"
    URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
    TEXT="Pipeline status: $2%0A%0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG%0ATag:+$CI_COMMIT_TAG%0ACommit:$CI_COMMIT_SHORT_SHA"

    curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
else
    TIME="10"
    URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
    TEXT="Starting pipeline: %0AProject:+$CI_PROJECT_NAME%0AURL:+$CI_PROJECT_URL/pipelines/$CI_PIPELINE_ID/%0ABranch:+$CI_COMMIT_REF_SLUG%0ATag:+$CI_COMMIT_TAG%0ACommit:$CI_COMMIT_SHORT_SHA"

    curl -s --max-time $TIME -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null
fi

