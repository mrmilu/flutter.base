if [ "$CONFIGURATION" == "Debug-beta" ] || [ "$CONFIGURATION" == "Release-beta" ]; then
  cp Runner/beta/GoogleService-Info.plist Runner/GoogleService-Info.plist
elif [ "$CONFIGURATION" == "Debug-live" ] || [ "$CONFIGURATION" == "Release-live" ]; then
  cp Runner/live/GoogleService-Info.plist Runner/GoogleService-Info.plist
fi

