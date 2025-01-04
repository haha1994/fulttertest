// import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:helloworld/login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../module/home/home_page.dart';
import '../../module/message/message_page.dart';
import '../../module/my/my_page.dart';
import '../../module/root/root_app.dart';
import '../../module/setting/settings.dart';
import '../../module/szdata/szdata.dart';
import '../../module/szdata/szdata_view.dart';
import '../../search.dart';
import '../common/router_page.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellRouteNavigatorKey = GlobalKey<NavigatorState>();
final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      /// ShellRoute 允许你定义一个持久化的布局（通常是底部导航栏），并在不同的标签页之间切换内容而不重新加载整个布局
      ShellRoute(
        navigatorKey: shellRouteNavigatorKey,
        builder: (context, state, child) => RootApp(child: child),
        // builder: (context, state, child) => const HomeView(title: 'Home Page',),
        routes: [
          GoRoute(
            path: "/",
            name: HomePage.name,
            // redirect: (context, state) async {
            //   /// 未登陆和首次登陆
            //   // final auth = await ref.read(authenticationProvider.future);
            //   //
            //   // if (auth == null && !KVStoreService.doneGettingStarted) {
            //   //   return "/getting-started";
            //   // }
            //
            //   return null;
            // },
            pageBuilder: (context, state) => const RouterPage(
                child: HomePage(
              title: 'Home Page',
            )),
            // routes: [
            // GoRoute(
            //   path: "genre/:categoryId",
            //   name: GenrePlaylistsPage.name,
            //   pageBuilder: (context, state) => RouterPage(
            //     child: GenrePlaylistsPage(
            //       category: state.extra as Category,
            //     ),
            //   ),
            // ),
            // GoRoute(
            //   path: "feeds/:feedId",
            //   name: HomeFeedSectionPage.name,
            //   pageBuilder: (context, state) => RouterPage(
            //     child: HomeFeedSectionPage(
            //       sectionUri: state.pathParameters["feedId"] as String,
            //     ),
            //   ),
            // )
            // ],
          ),

          /// 底部导航栏
          GoRoute(
            path: "/search",
            name: SearchPage.name,
            pageBuilder: (context, state) => const RouterPage(child: SearchPage()),
          ),
          GoRoute(
            path: "/my",
            name: MyPage.name,
            pageBuilder: (context, state) => const RouterPage(child: MyPage()),
          ),
          GoRoute(
            path: "/message",
            name: MessagePage.name,
            pageBuilder: (context, state) =>
                const RouterPage(child: MessagePage()),
          ),
          // GoRoute(
          //   path: "/szdata",
          //   name: InfiniteListView.name,
          //   pageBuilder: (context, state) =>
          //   const RouterPage(child: InfiniteListView()),
          // ),
          // GoRoute(
          //   path: "/szDataView",
          //   name: SzDataView.name,
          //   pageBuilder: (context, state) =>
          //   const RouterPage(child: SzDataView()),
          // ),
          // GoRoute(
          //     path: "/library",
          //     name: LibraryPage.name,
          //     pageBuilder: (context, state) =>
          //         const RouterPage(child: LibraryPage()),
          //     routes: [
          //       GoRoute(
          //         path: "generate",
          //         name: PlaylistGeneratorPage.name,
          //         pageBuilder: (context, state) =>
          //             const RouterPage(child: PlaylistGeneratorPage()),
          //         routes: [
          //           GoRoute(
          //             path: "result",
          //             name: PlaylistGenerateResultPage.name,
          //             pageBuilder: (context, state) => RouterPage(
          //               child: PlaylistGenerateResultPage(
          //                 state: state.extra as GeneratePlaylistProviderInput,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //       GoRoute(
          //         path: "local",
          //         name: LocalLibraryPage.name,
          //         pageBuilder: (context, state) {
          //           assert(state.extra is String);
          //           return RouterPage(
          //             child: LocalLibraryPage(state.extra as String,
          //                 isDownloads:
          //                     state.uri.queryParameters["downloads"] != null),
          //           );
          //         },
          //       ),
          //     ]),
          GoRoute(
            path: "/settings",
            name: SettingsPage.name,
            pageBuilder: (context, state) => const RouterPage(
              child: SettingsPage(),
            ),
            // routes: [
            //   GoRoute(
            //     path: "blacklist",
            //     name: BlackListPage.name,
            //     pageBuilder: (context, state) => SpotubeSlidePage(
            //       child: const BlackListPage(),
            //     ),
            //   ),
            //   if (!kIsWeb)
            //     GoRoute(
            //       path: "logs",
            //       name: LogsPage.name,
            //       pageBuilder: (context, state) => SpotubeSlidePage(
            //         child: const LogsPage(),
            //       ),
            //     ),
            //   GoRoute(
            //     path: "about",
            //     name: AboutSpotube.name,
            //     pageBuilder: (context, state) => SpotubeSlidePage(
            //       child: const AboutSpotube(),
            //     ),
            //   ),
            // ],
          ),
          // GoRoute(
          //   path: "/album/:id",
          //   name: AlbumPage.name,
          //   pageBuilder: (context, state) {
          //     assert(state.extra is AlbumSimple);
          //     return RouterPage(
          //       child: AlbumPage(album: state.extra as AlbumSimple),
          //     );
          //   },
          // ),
          // GoRoute(
          //   path: "/artist/:id",
          //   name: ArtistPage.name,
          //   pageBuilder: (context, state) {
          //     assert(state.pathParameters["id"] != null);
          //     return RouterPage(
          //         child: ArtistPage(state.pathParameters["id"]!));
          //   },
          // ),
          // GoRoute(
          //   path: "/connect",
          //   name: ConnectPage.name,
          //   pageBuilder: (context, state) => const RouterPage(
          //     child: ConnectPage(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: "control",
          //       name: ConnectControlPage.name,
          //       pageBuilder: (context, state) {
          //         return const RouterPage(
          //           child: ConnectControlPage(),
          //         );
          //       },
          //     )
          //   ],
          // ),
          // GoRoute(
          //   path: "/profile",
          //   name: ProfilePage.name,
          //   pageBuilder: (context, state) =>
          //       const RouterPage(child: ProfilePage()),
          // ),
          // GoRoute(
          //   path: "/stats",
          //   name: StatsPage.name,
          //   pageBuilder: (context, state) => const RouterPage(
          //     child: StatsPage(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: "minutes",
          //       name: StatsMinutesPage.name,
          //       pageBuilder: (context, state) => const RouterPage(
          //         child: StatsMinutesPage(),
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
      // GoRoute(
      //   path: "/mini-player",
      //   name: MiniLyricsPage.name,
      //   parentNavigatorKey: rootNavigatorKey,
      //   pageBuilder: (context, state) => RouterPage(
      //     child: MiniLyricsPage(prevSize: state.extra as Size),
      //   ),
      // ),
      // GoRoute(
      //   path: "/getting-started",
      //   name: GettingStarting.name,
      //   parentNavigatorKey: rootNavigatorKey,
      //   pageBuilder: (context, state) => const RouterPage(
      //     child: GettingStarting(),
      //   ),
      // ),
      GoRoute(
        path: "/szdata",
        name: InfiniteListView.name,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) =>
            const RouterPage(child: InfiniteListView()),
      ),
      GoRoute(
        path: "/szDataView",
        name: SzDataView.name,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => const RouterPage(child: SzDataView()),
      ),
      GoRoute(
        path: "/login",
        name: LoginPage.name,
        parentNavigatorKey: rootNavigatorKey,
        pageBuilder: (context, state) => const RouterPage(
          child: LoginPage(),
        ),
      ),
      // GoRoute(
      //   path: "/lastfm-login",
      //   name: LastFMLoginPage.name,
      //   parentNavigatorKey: rootNavigatorKey,
      //   pageBuilder: (context, state) =>
      //       const RouterPage(child: LastFMLoginPage()),
      // ),
    ],
  );
});
