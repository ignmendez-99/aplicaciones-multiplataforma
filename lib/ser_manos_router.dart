import 'package:aplicaciones_multiplataforma/models/user.dart';
import 'package:aplicaciones_multiplataforma/services/auth/auth_service.dart';
import 'package:aplicaciones_multiplataforma/services/novedad_service.dart';
import 'package:aplicaciones_multiplataforma/services/user_service.dart';
import 'package:aplicaciones_multiplataforma/services/voluntariado_service.dart';
import 'package:aplicaciones_multiplataforma/views/card_seleccionada.dart';
import 'package:aplicaciones_multiplataforma/views/dashboard.dart';
import 'package:aplicaciones_multiplataforma/views/edit_profile.dart';
import 'package:aplicaciones_multiplataforma/views/login.dart';
import 'package:aplicaciones_multiplataforma/views/novedad_page.dart';
import 'package:aplicaciones_multiplataforma/views/register.dart';
import 'package:aplicaciones_multiplataforma/views/start.dart';
import 'package:aplicaciones_multiplataforma/views/welcome.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/novedad.dart';

Key dashboardKey = GlobalKey();

class SerManosRouter {
  static final router = GoRouter(
    initialLocation: '/voluntariados',
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
            return '/miPerfil';
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
        path: '/voluntariados',
        name: 'voluntariados',
        builder: (context, state) {
          final String loggedUserId = Provider.of<AuthService>(context, listen: false)
              .currentUser!.id;
          final Future<User> loggedUser = Provider.of<UserService>(context, listen: false)
              .getUserById(loggedUserId);
          return Dashboard(
            loggedUser: loggedUser,
            // key: state.pageKey,
            // key: dashboardKey,
            initialTab: 0,
          );
        },
        routes: [
          GoRoute(
            path: ':voluntariadoId',
            name: 'voluntariado',
            builder: (context, state) {
              final voluntariadoId = state.pathParameters['voluntariadoId']!;
              final voluntariado = Provider.of<VoluntariadoService>(context, listen: false)
                  .getVoluntariadoById(voluntariadoId);
              return CardSeleccionada(voluntariado: voluntariado,);
            },
            redirect: (context, state) async {
              final voluntariadoId = state.pathParameters['voluntariadoId'];
              if(voluntariadoId == null) {
                return '/voluntariados';
              }
              final voluntariado = await Provider.of<VoluntariadoService>(context, listen: false)
                  .getVoluntariadoById(voluntariadoId);
              if(voluntariado == null) {
                return '/voluntariados';
              }
              return null; // no redirije
            }
          ),
        ],
      ),
      GoRoute(
        path: '/miPerfil',
        name: 'miPerfil',
        builder: (context, state) {
          final String loggedUserId = Provider.of<AuthService>(context, listen: false)
              .currentUser!.id;
          final Future<User> loggedUser = Provider.of<UserService>(context, listen: false)
              .getUserById(loggedUserId);
          return Dashboard(
            loggedUser: loggedUser,
            // key: dashboardKey,
            initialTab: 1,
          );
        },
        routes: [
          GoRoute(
            path: 'editProfile',
            name: 'editProfile',
            builder: (context, state) {
              final String loggedUserId = Provider.of<AuthService>(context, listen: false)
                  .currentUser!.id;
              final Future<User> loggedUser = Provider.of<UserService>(context, listen: false)
                  .getUserById(loggedUserId);
              return EditProfile(loggedUser: loggedUser);
            }
          )
        ],
      ),
      GoRoute(
        path: '/novedades',
        name: 'novedades',
        builder: (context, state) {
          final String loggedUserId = Provider.of<AuthService>(context, listen: false)
              .currentUser!.id;
          final Future<User> loggedUser = Provider.of<UserService>(context, listen: false)
              .getUserById(loggedUserId);
          return Dashboard(
            loggedUser: loggedUser,
            // key: dashboardKey,
            initialTab: 2,
          );
        },
        routes: [
          GoRoute(
            path: ':novedadId',
            name: 'novedad',
            builder: (context, state) {
              final novedadId = state.pathParameters['novedadId']!;
              final Future<Novedad?> novedad = Provider.of<NovedadService>(context, listen: false)
                  .getNovedadById(novedadId);
              return NovedadPage(novedadFuture: novedad);
            },
            redirect: (context, state) async {
              final novedadId = state.pathParameters['novedadId'];
              if(novedadId == null) {
                return '/novedades';
              }
              final Novedad? novedad = await Provider.of<NovedadService>(context, listen: false)
                  .getNovedadById(novedadId);
              if(novedad == null) {
                return '/novedades';
              }
              return null; // no redirije
            }
          )
        ]
      )
    ],
  );
}