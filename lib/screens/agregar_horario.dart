import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:horario/router/router.dart';
import 'package:horario/widgets/side_menu.dart';
import 'package:intl/intl.dart';

class AgregarScreen extends StatefulWidget {
  const AgregarScreen({super.key});

  @override
  _AgregarScreenState createState() => _AgregarScreenState();
}

class _AgregarScreenState extends State<AgregarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _events = {}; // Almacena eventos por fecha

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      endDrawer: const SideMenu(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: colors.primary,
        title: const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Agregar Horario',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),

      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Seleccione la Fecha',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Calendario Mensual
            TableCalendar(
              calendarFormat: _calendarFormat,
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2101),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue, // Color de fondo para la fecha seleccionada
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              selectedDayPredicate: (DateTime date) {
                // Aquí defines la lógica para resaltar la fecha seleccionada.
                // Por ejemplo, puedes comparar la fecha actual con la seleccionada (_selectedDay).
                return isSameDay(date, _selectedDay);
              },
            ),

            ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () {
                // Verifica si _selectedDay no está en la lista de fechas
                if (!_events.containsKey(_selectedDay)) {
                  setState(() {
                    // Agrega _selectedDay a la lista de fechas
                    _events[_selectedDay] = [DateFormat('yyyy-MM-dd').format(_selectedDay)]; // Puedes agregar más eventos si es necesario
                  });
                }
              },
            ),

            // Espacio para mostrar eventos
            Expanded(
              child: ListView.builder(
                itemCount: _events[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  final event = _events[_selectedDay]?[index];
                  return ListTile(
                    title: Text(event ?? ''),
                  );
                },
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Mostrar un diálogo al presionar el botón "Finalizar"
                showDialog(
                  context: context, // El contexto actual
                  builder: (BuildContext context) {
                    // Aquí defines el contenido del diálogo
                    return AlertDialog(
                      title: Text('¿Estas Seguro?'),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      content: Column(
                        children: <Widget>[
                          Text('¿Estás seguro que quieres guardar los horarios establecidos?'),
                          SizedBox(height: 12), // Espacio entre el texto y la imagen
                          Image.asset('assets/estas seguro.png'),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  // Cerrar el diálogo
                                  Navigator.of(context).pop();
                                },
                                child: Text('CANCELAR'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Cierra el diálogo
                                  appRouter.go('/home');
                                },
                                style: TextButton.styleFrom(
                                  primary: Color(0xFFFD5D5D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero, // Forma del diálogo (rectangular)
                                  ),// Establece el color del botón
                                ),
                                child: Text('ACEPTAR'),
                              ),
                            ],
                          )// Reemplaza 'assets/imagen.png' con la ruta de tu imagen
                        ],
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFD5D5D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Text(
                'Finalizar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
