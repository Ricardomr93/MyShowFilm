class Constants {
  Constants._(); //constructor privado
  static const int NUM_FILMS_NOW = 6;
  static const int NUM_FILMS_POPULAR = 20;

  static const String NO_MORE_FILM = 'No hay mas';
  static const String SOME_CHANGE = 'Debes modificar algún campo';
  static const String ERROR = 'Error';
  static const String INFO = 'Info';
  static const String EM_OR_PAS_NO = 'Email o contraseña erroneos';
  static const String EMAIL_USE = 'Email ya está registrado';
  static const String MSJ_TXT_EMPTY = 'El campo no debe estar vacío';
  static const String REQUIRE_LOGIN = 'Requiere volver a loguearse';
  static const String NAME_SPACE = 'Nombre de usuario contiene espacios';
  static const String EMAIL_NO_VALID = 'Email no válido';
  static const String PASS_WEAK = 'La contraseña tiene menos de 6 caracteres';
  static const String NOT_COMMENTS = 'No hay comentarios...';

  //image
  static const double SIZE_PROFILE = 160;
  static const double SIZE_ICON_COMENT = 40;
  //menu
  static const String LABEL_FILMS = 'Películas';
  static const String LABEL_SERIES = 'Series';
  static const String LABEL_FOLLOWER = 'Seguidores';
  static const String LABEL_FOLLOWED = 'Seguidos';

  //profile
  static const String LABEL_BACK = 'Atrás';
  static const String GALLERY = 'Galería';
  static const String CAMERA = 'Cámara';
  static const String LABEL_EDIT_PROFILE = 'Editar perfil';
  static const String LABEL_FRIENDS = 'Amigos';
  static const String LABEL_LOGOUT = 'Cerrar sesión';
  static const String NOM_USER_PRED = 'Usuario';
  static const String IMAGE_PRED =
      'https://www.softzone.es/app/uploads-softzone.es/2018/04/guest.png';

  //rutas
  static const String ROUTE_LOGIN = 'login';
  static const String ROUTE_SPLASH = 'splash';
  static const String ROUTE_SING = 'sing';
  static const String ROUTE_HOME = 'home';
  static const String ROUTE_PROFILE = 'profile';
  static const String ROUTE_EDIT_PROFILE = 'edit_profile';
  static const String ROUTE_O_USR_PROFILE = 'o_usr_profile';
  static const String ROUTE_DETAILS_FILM = 'details_film';
  static const String ROUTE_LIST_FRIENDS = 'lists_friends';

  //botones
  static const String BUTTOM_LOGIN = 'CONECTAR';
  static const String BUTTOM_SING = 'REGISTRARSE';
  static const String BUTTOM_SAVE = 'GUARDAR';
  static const String BUTTOM_DELETE_AC = 'BORRAR CUENTA';
  static const String BUTTOM_FOLLOW = 'SEGUIR';
  static const String BUTTOM_UNFOLLOW = 'SIGUIENDO';

  //provider
  static const String PROVIDER_GOOGLE = 'Google';
  static const String PROVIDER_FACE = 'Facebook';
  static const String PROVIDER_EMAIL = 'Email';
  static const String PROVIDER_LOGOUT = 'Logout';
  static const String PROVIDER = 'Provider';

  //textfield
  static const String TEXT_NAME = 'Nombre usuario';
  static const String TEXT_EMAIL = 'Email';
  static const String TEXT_PASS = 'Contraseña';
  static const String TEXT_COMMENT = 'Añadir comentario...';
  static const int MAX_LENGTH_FIELD = 20;
  static const int MAX_LENGTH_COMMENT = 300;

  //no / account
  static const String MSJ_COUNT = '¿Ya tienes una cuenta? ';
  static const String MSJ_NO_COUNT = '¿No tienes cuenta?  ';

  //login
  static const String MSJ_OR = 'O';
  static const String MSJ_SING_USING = 'Registrate usando';
  static const String MSJ_SING_UP = 'Registrate';

  //sing up
  static const String MSJ_LOG_IN = 'Login';

  //navigation bottom
  static const String NAV_HOME = 'Inicio';
  static const String NAV_SEARCH = 'Buscar';

  //loanding
  static const String TRY_LOGIN = 'Logueando';
  static const String TRY_LOGIN_F = 'Logueando con Facebook';
  static const String TRY_LOGIN_G = 'Logueando con Google';
  static const String TRY_SING = 'Registrando';
  static const String TRY_UPDATE = 'Modificando perfil';

  //user
  static const String USER_ID = 'idUser';
  static const String USER_NAME = 'userName';
  static const String USER_EMAIL = 'email';
  static const String USER_AVATAR = 'avatar';
  static const String USER_PASS = 'pass';
  static const String USER_DELETE = 'delete';
  static const String USER_FOLLOWER = 'followers';
  static const String USER_FOLLOWED = 'followed';

  //film
  static const String FILM_ID = 'idFilm';
  static const String FILM_COMMENT = 'comments';
  static const String FILM_VOTES = 'votes';
  //comments
  static const String COMMENT_IDU = 'idUser';
  static const String COMMENT_MSJ = 'msj';
  //votes
  static const String VOTE_IDU = 'idUser';
  static const String VOTE_VOTE = 'vote';
  //firebase
  static const String COLL_FILM = 'films';
  static const String COLL_SERIE = 'series';
  static const String COLL_USER = 'users';
  static const String COLL_COMMENT = 'comments';

  //hero
  static const String HERO_PROFILE = 'profile';
}
