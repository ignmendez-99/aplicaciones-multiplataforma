import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/voluntariado_service.dart';
import 'package:aplicaciones_multiplataforma/views/card_seleccionada.dart';
import 'package:aplicaciones_multiplataforma/views/dashboard.dart';
import 'package:aplicaciones_multiplataforma/views/login.dart';
import 'package:aplicaciones_multiplataforma/views/register.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SerManosRouter {
  static final router = GoRouter(
    initialLocation: '/dashboard/0',
    redirect: (context, state) {
      // Ponemos este metodo arriba del arbol para que cubra todas las pantallas
      // Eso significa que corre siempre que se quiere acceder a cualquier pantalla
      if(Provider.of<AuthService>(context, listen: false).currentUser == null
          && !['/start', '/start/register', '/start/login'].contains(state.location)) {
        return '/start';
      }
      return null; // no redirije
    },
    routes: [
      GoRoute(
        path: '/start',
        name: 'start',
        builder: (context, state) => const Start(),
        redirect: (context, state) {
          if(Provider.of<AuthService>(context, listen: false).currentUser != null) {
            // Si abro un deep link desde afuera que me manda a /start, que me redirija a mi perfil
            return '/dashboard/1';
          }
          return null; // no redirije
        },
        routes: [
            GoRoute(
              path: 'register', // /start/register
              name: 'register',
              builder: (context, state) => const Register(),
            ),
            GoRoute(
              path: 'login',  //  /start/register
              name: 'login',
              builder: (context, state) => const Login(),
            ),
          ]
      ),
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const Welcome(),
      ),
      GoRoute(
        path: '/dashboard/:tabId', //   /home/1-2-3
        name: 'dashboard',
        builder: (context, state) => Dashboard(
          key: state.pageKey,
          initialTab: int.parse(state.pathParameters['tabId'] ?? '0'),
        ),
        routes: [
          GoRoute(
            path: 'voluntariados/:voluntariadoId',
            name: 'voluntariados',
            builder: (context, state) {
              final voluntariadoId = state.pathParameters['voluntariadoId']!;
              final voluntariado = Provider.of<VoluntariadoService>(context, listen: false)
                  .getVoluntariadoById(voluntariadoId);
              return CardSeleccionada(voluntariado: voluntariado,);
            },
            redirect: (context, state) async {
              final voluntariadoId = state.pathParameters['voluntariadoId'];
              if(voluntariadoId == null) {
                return '/dashboard/0';
              }
              final voluntariado = await Provider.of<VoluntariadoService>(context, listen: false)
                  .getVoluntariadoById(voluntariadoId);
              if(voluntariado == null) {
                return '/dashboard/0';
              }
              return null; // no redirije
            }
          ),
        ],
      )
    ],
  );
}