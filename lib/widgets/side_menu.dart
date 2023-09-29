import 'package:flutter/material.dart';

List<Map<dynamic, dynamic>> navigationSection = [
  {
    'icon': Icons.lock,
    'text': 'Seguridad y privacidad',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.verified,
    'text': 'Token digital',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.qr_code,
    'text': 'Operar con QR',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.book,
    'text': 'Experiencias',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.account_balance_wallet,
    'text': 'Operativas',
    'navigationPath': '/medico'
  },
  {
    'icon': Icons.settings,
    'text': 'Configuración',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.error,
    'text': 'SOS Cliente',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.rotate_right,
    'text': 'Solicitar revisión',
    'navigationPath': '/medico',
  },
  {
    'icon': Icons.help,
    'text': 'Acerca de DockSeeker',
    'navigationPath': '/medico',
  }
];

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    int navDrawerIndex = 0;

    return NavigationDrawer(
        selectedIndex: navDrawerIndex, children: [
      for (var item in navigationSection)
        NavigationDrawerDestination(
          icon: Icon(item['icon']!),
          label: Text(item['text']!),
        ),
    ]);
  }
}
