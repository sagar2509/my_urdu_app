'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "86a78f3b6827fb30bb73b14dab4a1855",
"version.json": "6dfdcc2c69ab09dfd141236688c6eb83",
"macos/Runner.xcworkspace/contents.xcworkspacedata": "7053ea3423578187357b9f92d0c67fc6",
"macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"macos/RunnerTests/RunnerTests.swift": "97d3a20fd20a063c192e886d1822b4a8",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png": "8bf511604bc6ed0a6aeb380c5113fdcf",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png": "c9becc9105f8cabce934d20c7bfb6aac",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png": "dfe2c93d1536ae02f085cc63faa3430e",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png": "04e7b6ef05346c70b663ca1d97de3ad5",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png": "0ad44039155424738917502c69667699",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png": "3ded30823804caaa5ccc944067c54a36",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "5bd47c3ef1d1a261037c87fb3ddb9cfd",
"macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png": "8e0ae58e362a6636bdfccbc04da2c58c",
"macos/Runner/DebugProfile.entitlements": "6e164fc6ed6acb30c71fe12e29e49642",
"macos/Runner/Base.lproj/MainMenu.xib": "a41bc20792a7e771d7901124cdb8c835",
"macos/Runner/MainFlutterWindow.swift": "4a747b1f256d62a2bbb79bd976891eb5",
"macos/Runner/Configs/AppInfo.xcconfig": "2b98c1df5a8d55cc3e4745a250f33b5f",
"macos/Runner/Configs/Debug.xcconfig": "0a7555f820f3e4371d88ec1c339d70ef",
"macos/Runner/Configs/Release.xcconfig": "d36330778580798c0d9c5a5b71501a0f",
"macos/Runner/Configs/Warnings.xcconfig": "e19c2368cf97e5f3eaf8de37cff2b341",
"macos/Runner/AppDelegate.swift": "ce90ac27873ef28bc53a7dbc142459e5",
"macos/Runner/Info.plist": "b945a5051bb1cca2d906ac0be98b629a",
"macos/Runner/Release.entitlements": "e6fde05dec64f9856d3978a4a5e4bf48",
"macos/Runner.xcodeproj/project.pbxproj": "76ae9edaeec2622f20dbfa5d1302c2d2",
"macos/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"macos/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "adca08238ee926af6259df6730ce6098",
"macos/Flutter/Flutter-Debug.xcconfig": "2b03faed3e462ed0ed348559e4796ed8",
"macos/Flutter/GeneratedPluginRegistrant.swift": "c840bc53b61279c2fb631741134c2ed7",
"macos/Flutter/Flutter-Release.xcconfig": "2b03faed3e462ed0ed348559e4796ed8",
"macos/Flutter/ephemeral/flutter_export_environment.sh": "713fcc67e428a13b253cc4c0189e6dc7",
"macos/Flutter/ephemeral/Flutter-Generated.xcconfig": "785cde92db20b519b6f58b7b84da2cd4",
"index.html": "6c83b9204c4285153918995b8f65726c",
"/": "6c83b9204c4285153918995b8f65726c",
"test/widget_test.dart": "a2200422856fba5348290102a4d14095",
"main.dart.js": "65c8c758ac27605164cb0ff1e8c3bb40",
"web/index.html": "2c7eb0d3712eecb074d794730c939757",
"web/favicon.png": "5dcef449791fa27946b3d35ad8803796",
"web/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"web/icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"web/icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"web/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"web/manifest.json": "e33cbaf8e9e7f20ff6d4d806a61e6b36",
"pubspec.lock": "71283c7b153dbef3f3def7b97ccc820f",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"ios/Runner.xcworkspace/contents.xcworkspacedata": "7053ea3423578187357b9f92d0c67fc6",
"ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"ios/RunnerTests/RunnerTests.swift": "a225a382d14d7b16b6f602a5c1d49331",
"ios/Runner/Runner-Bridging-Header.h": "e07862ac930ed4d8479185d52c6cc66d",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/README.md": "e175e436acacf76c814d83532d0b662c",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/Contents.json": "770f4f65e02ca2fc57f46f4f4148d15d",
"ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png": "978c1bee49d7ad5fc1a4d81099b13e18",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png": "643842917530acf4c5159ae851b0baf2",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png": "be8887071dd7ec39cb754d236aa9584f",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png": "2247a840b6ee72b8a069208af170e5b1",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png": "a2f8558fb1d42514111fbbb19fb67314",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png": "c785f8932297af4acd5f5ccb7630f01c",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png": "665cb5e3c5729da6d639d26eff47a503",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png": "1b3b1538136316263c7092951e923e9d",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Contents.json": "c3cdf9688b604d14f2e76a8287e16167",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png": "2247a840b6ee72b8a069208af170e5b1",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png": "2b1452c4c1bda6177b4fbbb832df217f",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png": "8245359312aea1b0d2412f79a07b0ca5",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png": "e419d22a37bc40ba185aca1acb6d4ac6",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png": "36c0d7a7132bdde18898ffdfcfcdc4d2",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png": "5b3c0902200ce596e9848f22e1f0fe0e",
"ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png": "043119ef4faa026ff82bd03f241e5338",
"ios/Runner/GeneratedPluginRegistrant.h": "decb9041b5e91a07e66f4664e5dac408",
"ios/Runner/Base.lproj/LaunchScreen.storyboard": "89e8363b3b781ee4977c3c9422b88a37",
"ios/Runner/Base.lproj/Main.storyboard": "0e0faca0bc5766e8640496223a31706a",
"ios/Runner/AppDelegate.swift": "359eaeba058f8e8f89a6878e62764464",
"ios/Runner/GeneratedPluginRegistrant.m": "f6079b630997f8fd4ae1ac639162419a",
"ios/Runner/Info.plist": "f339919911a8b3af3234cd63810d579c",
"ios/Runner.xcodeproj/project.pbxproj": "3682cb912378375a0f630608f7c59101",
"ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata": "a54b6450d65c401d48911394f6a65bd2",
"ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist": "117105d2f2ee718eb485a07574a219b6",
"ios/Runner.xcodeproj/project.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings": "56b1e4b1f6b3b790f471044c301e69ea",
"ios/Runner.xcodeproj/xcshareddata/xcschemes/Runner.xcscheme": "ffac881d52d43c06cc1b45b6aeabc194",
"ios/Flutter/flutter_export_environment.sh": "a68bfd6469aa4636ab279adedff49970",
"ios/Flutter/Debug.xcconfig": "bd6254e10068a9a3539aa9710626ac24",
"ios/Flutter/Release.xcconfig": "bd6254e10068a9a3539aa9710626ac24",
"ios/Flutter/AppFrameworkInfo.plist": "5eb1ee18836d512da62e476379865f8d",
"ios/Flutter/Generated.xcconfig": "9a1d98850cb8433922f3fc7ea32d532a",
"README.md": "bbf92984501d6673508f2cc4daea963a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"pubspec.yaml": "060d6c785c5fe9374da6ca17a9996449",
"android/app/build.gradle": "84fe97d642b0d4e9bf560fcbdf2506e9",
"android/app/src/profile/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"android/app/src/main/res/mipmap-mdpi/ic_launcher.png": "6270344430679711b81476e29878caa7",
"android/app/src/main/res/mipmap-hdpi/ic_launcher.png": "13e9c72ec37fac220397aa819fa1ef2d",
"android/app/src/main/res/drawable/launch_background.xml": "79c59c987bd2e693cd741ec3035ef383",
"android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": "57838d52c318faff743130c3fcfae0c6",
"android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png": "afe1b655b9f32da22f9a4301bb8e6ba8",
"android/app/src/main/res/values-night/styles.xml": "feddd27a2f77ef486e2b7a420b1de43d",
"android/app/src/main/res/values/styles.xml": "58b48ec178bde5aad76063577172ad24",
"android/app/src/main/res/drawable-v21/launch_background.xml": "ab00f2bfdce1a5187d1ba31e9e68b921",
"android/app/src/main/res/mipmap-xhdpi/ic_launcher.png": "a0a8db5985280b3679d99a820ae2db79",
"android/app/src/main/AndroidManifest.xml": "83cb0c0684cbf806bb2a00ecc298a456",
"android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java": "5b3b418ce50367c33bded3c0df06d47f",
"android/app/src/main/kotlin/com/example/setup_tools_createnewworkspace/MainActivity.kt": "aa69a4d6ae9be778057f8953edc19645",
"android/app/src/debug/AndroidManifest.xml": "ac1dad6fec40014c3c6cbbd849a880dc",
"android/local.properties": "d744eb7e888654b118e0f4b048e4dd62",
"android/gradle/wrapper/gradle-wrapper.properties": "8326b56294256808fb7a0f9cf951861f",
"android/build.gradle": "8fea88f0221dc81c23b0e4c55c169ccc",
"android/gradle.properties": "573ed21eb5753ef2f22b26f8479d6797",
"android/settings.gradle": "cf3dd80f7045154dfd2292c09a963f1e",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "e33cbaf8e9e7f20ff6d4d806a61e6b36",
"lib/core/constants.dart": "a1658d849e28e5e46748fa7d421ac66a",
"lib/chapters/chapters_data.dart": "949713c56edb1e766c9308536092335a",
"lib/models/urdu_char.dart": "b4457b4f7285abc759814e12e16ec4c6",
"lib/main.dart": "6b8d635c7296a4e8dace2ddf4d81ce34",
"lib/data/char_registry.dart": "65837e76bb8651cf75faa36fcc4a2da0",
"lib/widgets/char_card.dart": "41af4083fdff7792ebaada82366cfc3b",
"analysis_options.yaml": "66d03d7647c8e438164feaf5b922d44a",
".dart_tool/package_config.json": "60207db07772afbd2b53ebc52581cacb",
".dart_tool/dartpad/web_plugin_registrant.dart": "7ed35bc85b7658d113371ffc24d07117",
".dart_tool/package_config_subset": "2ad0ca1ebedf80463385b0dce124489d",
".dart_tool/version": "b33e8cb326b8fe86bfc5c51244d72ae1",
".git/ORIG_HEAD": "1f4785910c3aa6c76c2a54231de046a9",
".git/config": "feda3a4e59a3d6d90a79b563704f1084",
".git/objects/95/2b7bd620fd5f8826394fec412e2cd6d6a56f5c": "c05f2a813ee1d714fc60abffb771ce1d",
".git/objects/95/c667d535608680eaf0e1e087b51c035c75dbbf": "d1dc9a534220ffff3ce24946835c5575",
".git/objects/59/cd4087c5f84f5a60d8aecc0eca1c8a55c77e6c": "92513ca2618cf3c43c57026c4f523479",
".git/objects/66/6c6b4060eff8f38d7d5747c02bb9a73d9a6871": "156ae5b43ab802997614aadb8f8ba0f6",
".git/objects/3e/746b49c829b0aa10a02f6762c0491dbf46a4c3": "dce6c9ecef1f5b30436d9815f156d431",
".git/objects/57/e9af256fa8bf42142c4756aff3cf4ff3541c51": "168eb7f0b67188566a83f2813511fbb7",
".git/objects/56/8d58fa69dbe3a7766ecdefdee1bdbf935cafa3": "efbae330114d1bd0d30579a28caf8354",
".git/objects/58/b007afeab6938f7283db26299ce2de9475d842": "6c6cbea527763bb3cdff2cecfee91721",
".git/objects/58/356635d1dc89f2ed71c73cf27d5eaf97d956cd": "f61f92e39b9805320d2895056208c1b7",
".git/objects/94/f7d06e926d627b554eb130e3c3522a941d670a": "77a772baf4c39f0a3a9e45f3e4b285bb",
".git/objects/34/c9d3a24be7644eb552b3abfa8eaf369495bc47": "90c7d06bf8726eee8365f175230b9abd",
".git/objects/05/8eba65dfa5894bc0b0654de276b15206cb2adf": "166c2a1f602948828d1d7e2dc17ee746",
".git/objects/02/8c630d641011d3510691dea4793aa425e3c033": "9cc6800e9a3a8b871a97ce7c48097610",
".git/objects/ac/580d73eab50ba7d47d860b3847687b202b3bcd": "4e924991f5f1bca1974ef4b3a0abe233",
".git/objects/d7/f5f8ca4d0d3f188c686c56d8e0043bea424106": "b1ad3e728957cf6cd2e0b3b6c9de168e",
".git/objects/b3/ebbd38f666d4ffa1a394c5de15582f9d7ca6c0": "23010709b2d5951ca2b3be3dd49f09df",
".git/objects/b4/a3ecb9428e2a4b8aff40c099e1c27d64a928f0": "6e4bc29289eb6be950713f1b329eaf0d",
".git/objects/d1/098e7588881061719e47766c43f49be0c3e38e": "f17e6af17b09b0874aa518914cfe9d8c",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/f4/d0c34911124ef3088b50a10202546f19cb55dd": "0adb8c473ca27c3879be5e3013a51619",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/baf066957bbc2e9f9903063c378974e078188f": "e51b5645fd8f182611c6d13ddd728a17",
".git/objects/eb/bbacf638d86f4b64a4d95a4db9c83ab1571225": "c680bfabb9b5ead7a2ff414c9f3285f5",
".git/objects/c7/819e23817e4fbf63b6ac559c5f59eef363dd62": "8a6c2a9330083b8fef03da4ce8e05c0a",
".git/objects/c7/7c040079bc9ab9c636b7e8f58a6136fcf0fe3d": "7ad74193c70223d755c74a339592d34b",
".git/objects/c0/c6f1390e3afc0a18456cf1d59869e483346a46": "c9bc8d7afe6ff6af8b7305ab9c842905",
".git/objects/ee/bd1723d039ecefd3bcce03035f62f2e7a3414a": "c519886acac509fc82e5510199f74a07",
".git/objects/c9/bf8af1b92c723b589cc9afadff1013fa0a0213": "632f11e7fee6909d99ecfd9eeab30973",
".git/objects/c9/8a8ed75dfea5cd65bec85ee8495bd1d089b4c7": "8d4de1437080f897916882d141a14ad1",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f5/400830fc3222ae22926e13fd4fb8cc83facb9b": "a7694d54d9b5294459aa6b68871c356e",
".git/objects/ca/8482c88c44dcfdf9ead9d3726df9574ac9775c": "81cbf504c8b90bc81a07b514349a4ac5",
".git/objects/fe/16d96c80afe50c67e48ecb8b4d3b29773e0555": "79b6a11050f7717216287d65610ef670",
".git/objects/fe/0c870f444af965005880e75a075ba78cc54f72": "e50f5315b69d84310924239c5648f79a",
".git/objects/20/cb2f80169bf29d673844d2bb6a73bc04f3bfb8": "b807949265987310dc442dc3f9f492a2",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/18/eb401097242a0ec205d5f8abd29a4c5e09c5a3": "4e08af90d04a082aab5eee741258a1dc",
".git/objects/4b/d299a0ce1d59f308c5acd1b9cca2ea59f2470a": "2c5be5f95ccb8c7e213963db77329c8a",
".git/objects/pack/pack-05552e596e0d6417634cabf1c7953c4bb3204a8d.idx": "88bd10a8002064accce506882b56c6ef",
".git/objects/pack/pack-05552e596e0d6417634cabf1c7953c4bb3204a8d.pack": "ca4f2dfc784a2f603136c5584818fee3",
".git/objects/7c/09d499f23e8c9cfadbd067e09e62b423cd8b4a": "4f5d6ea007527788d254cd3ceeb9b8a8",
".git/objects/7c/e8b11319f6eb2bcabb78e1f6fa78ef8deb6c0f": "d3b8d12211e3eca0d56baa2e4377c0b0",
".git/objects/7c/d97d779deb59a18af396b5ffc3f13db1479ab4": "7a9f393415d462c2d4ebb220568a15f4",
".git/objects/42/5d1955a0ffb80afc7480e7ecf5f3f36d257507": "09994fd78e1b89b36314c819679e619d",
".git/objects/89/b6d2e760ee1b548c0b229805298898eb623577": "ffc4cf1dac06503dd1b7d2bf70ff7eb5",
".git/objects/1f/09232ef691469b5a718e43ecaa51fbd3338404": "01589d1f2096ececc8e8866e85f0cf80",
".git/objects/1f/1313760d3ba21bc20d22f90010f0806428f199": "156c55b89d4f0f6c82344f2babd244a6",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/80/411d2281949de45dbd1c22a33602ab1bcd1eb1": "861cdacdf4a020a2c4e6cee8c3f434bd",
".git/objects/28/5b59527c6df5a2c0b66e197daa66bb955a7cd0": "33eccee6787b98b93862d4b806460b8c",
".git/objects/28/12b19bbaf6bfbba4a7af2686b10264254c9f8d": "096aed42e081c0a4bc240c0ea381ce82",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/10/cd66502d03a49978197b842f7fb99d6bce8543": "c9bea008d0df175f2db8ea35b5553981",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/07/8f1f8d24ef64b0f04fbe80ee059ba87175eb5b": "b0574f1bb7fa841551c7bc71cb2a7e8d",
".git/objects/09/4bb6ae24f0cd847d40cb4cc4a2434f2ec9b83b": "b9e6d850322c11db635bcf0a45b762ff",
".git/objects/31/5566e2b8e6f166b3f065b42b4ef5a4fe34a491": "0cf0fd218c52df6c510bb6750e90ce9c",
".git/objects/91/2799818a92e9b885ac276225f0d08b90b7f10b": "bc0981388abc05c6bb1a48b01b5f49fe",
".git/objects/6d/c109dc5ecb293b827a1c85f440ec4d0354714a": "e0c6f4175f8d867b95a3eac59683ef35",
".git/objects/06/c983fa3356e2976d8feb903f47bd36071e60a4": "4022dd54226eabe337ee4e1b5603cde8",
".git/objects/52/1194fd4a40579cd0403c71762d6ba81b821619": "02ad13e4c5cb9c0cc6eb238074fc50ce",
".git/objects/55/13e9d74f76ea3cb75ab37edeac3f3e916db55d": "b8e29e870547057f4582855e8a115670",
".git/objects/55/bc7e616db42603bfc35187580b0c3f2f3aee59": "c1b659e5beddd54916a9df13b6f0b7ef",
".git/objects/90/06cf8f4dd0fc0b8a45881302b398c5a8b24b27": "4ce33f1fc21faab0bb69c5e91f11b141",
".git/objects/90/05f17be81698acec64cd90b753e0996bda5dc1": "5573ef894d369a03e6a2964623a71512",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/cc/bda83bb3aa2b8e680e2451b31979b76f391600": "c9df456a8c1ddf8433bd5d7f4ee8c9ee",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/e8/d6d95d0124b33c0e0b029461d37f5f5b485b61": "e798938dbdb1ace7a1294eb2a7cc5357",
".git/objects/c5/fe77e046ab6f0613096b0e352c504a1ed79ca3": "e2ab2a466352c5115ff2336f9e684b26",
".git/objects/2d/e2c2aed29e5020a7e5aad48d7e69e866c49b78": "61278c8275c26eb58cac90b5413cf056",
".git/objects/1b/17ad079a29a80e3c04c1af0f0114d6895cf67a": "18e0f6119bf01e645561cad1a4263377",
".git/objects/48/99ecb0918a793ea76be2b81d3f38e43d80b5e5": "84f85940c2eedf0e2f1d1393d3bda3fc",
".git/objects/70/9229095422410eb8cfb9edee3d03ede5d9c7de": "d9ded1645953520c39008357527ddcab",
".git/objects/12/d4f160331f185793c4bb57e0e7085992d217cc": "169a800307ee7258329b7e90ca0988bd",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/71/7173cfc1bbfee2e0798dd5dea01270e23ca80b": "b00c68134435ff43abd6e797318a4c99",
".git/objects/71/8304e64f9d3c8a2e1bf257154099cda6e76f4a": "2ca00fbf79a681c0bfdb5af7991dd116",
".git/objects/71/3f932c591e8f661aa4a8e54c32c196262fd574": "66c6c54fbdf71902cb7321617d5fa33c",
".git/objects/49/adebdb511c8c293b28db3f6792e5bac28cdc32": "ba6a3971e7f06834fd6ec3844372ce17",
".git/objects/49/5ca89828da09c5c1196d7a8fe7da9809d1d69d": "7b6f377f77b6417f823a3d5e350ce0e0",
".git/objects/40/b788e8d6820ac254836316133ba4eb5fcc02b0": "8fffb3150c08dc19193c87a027b12619",
".git/objects/2e/5877510b4f999c9a267d7f8d04a5c788f3e371": "6a6633337abfa7aadfb40b3a83470257",
".git/objects/2b/7be823c4c19a8b1a4c63214b1372dff486e916": "258624ad2c514c1d0f12c84c9b8aa945",
".git/objects/8b/1b71566f8062a8699e53b8e1869f5e98cea8a7": "bebd6c09da918413f29422c04017848a",
".git/objects/13/f81366fa713e961569af3b730e47ff450413f3": "0e2d86fa997e11adc1431a61b986f78f",
".git/objects/22/1065f24e9dc43225e9c2eb6f99a9e9e78abd31": "8cb4cde5ea2b46f63eeacd6639cd208c",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/HEAD": "5ab7a4355e4c959b0c5c008f202f51ec",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "c990da7ff40061a09bf1ce08f6463aab",
".git/logs/refs/heads/gh-pages": "153e46265c26ef61829c43ae8084699b",
".git/logs/refs/remotes/origin/gh-pages": "e3246df5cf5d82797caa5cdee3cc5cd0",
".git/logs/refs/remotes/origin/main": "924e7c9c16aa11b420ac87651fb0871e",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/fsmonitor-watchman.sample": "ea587b0fae70333bce92257152996e70",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/refs/heads/gh-pages": "7d8dc71c6b40984d3dab9b1cd72a59fe",
".git/refs/remotes/origin/gh-pages": "7d8dc71c6b40984d3dab9b1cd72a59fe",
".git/refs/remotes/origin/main": "1eaa145a96772bff4896ca13301a6d66",
".git/index": "b14064e08e0e4088a82dfc53a8fce757",
".git/COMMIT_EDITMSG": "513d44392d8100a2e4d9a127c6cdba38",
".git/FETCH_HEAD": "d45237814cb32b005de5ef654c5c7c53",
"assets/AssetManifest.json": "e679fdadfdc77114724b027e76ae0d1b",
"assets/NOTICES": "f1ded662473c087c0dc50661431ed252",
"assets/FontManifest.json": "4b270ff04c2519f3984e4f20b2eba888",
"assets/AssetManifest.bin.json": "8716619d6fd12914010ede75b6c30622",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "2bab939f8441a634060b869093431012",
"assets/fonts/MaterialIcons-Regular.otf": "19147c907af9492bbea072a995fd0e83",
"assets/fonts/JameelNooriNastaleeqKasheeda.ttf": "0feabd6c9714cc4bb922bfb16e1ef20f",
"assets/assets/fonts/Inter-VariableFont.ttf": "0a77e23a8fdbe6caefd53cb04c26fabc",
"assets/assets/fonts/JameelNooriNastaleeqKasheeda.ttf": "0feabd6c9714cc4bb922bfb16e1ef20f",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
