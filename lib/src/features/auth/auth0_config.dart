import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:welangflood/src/common_widets/transition/transition.dart';
import 'package:welangflood/src/features/screens/home/home.dart';

final Auth0 auth0 = Auth0(
  clientId: 'QXcBQwzxgp6Fgjw0VBbbKyFczYQqjTK0',
  domain: 'dev-fqiljwfi74k1obuu.us.auth0.com',
);

void loginWithAuth0(BuildContext context) async {
  try {
    final authResult = await auth0.webAuth.authorize({
      'response_type': 'token',
      'client_id': 'YOUR_CLIENT_ID',
      'redirect_uri': 'YOUR_REDIRECT_URI',
      'scope': 'openid profile email',
    });
    print('Access token: ${authResult.accessToken}');
    TransitionUtils.navigateWithFadeTransition(context, const Home());
  } catch (e) {
    print('Error during login: $e');
  }
}

