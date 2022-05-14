echo "1. APK"
echo "2. AppBundle"
while :
do 
	read -p "Build to: " input
	case $input in
		1)
		flutter build apk --target-platform android-arm,android-arm64 --release -v
		break
		;;
		2)
		flutter build appbundle --target-platform android-arm,android-arm64 --release -v
		break
		;;
		*)
		;;
	esac
done
echo "Build successfully!"