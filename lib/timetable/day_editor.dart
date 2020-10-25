import 'package:tasker/reusable/slikker.dart';

class DayEditor extends StatefulWidget {
   final Map oldDay;
   final double accent;

   const DayEditor({ 
      this.oldDay = const {'projects': []},
      this.accent = 240 
   });

   @override _DayEditorState createState() => _DayEditorState();
}

class _DayEditorState extends State<DayEditor> {

   Map newDay;

   @override void initState() {
      super.initState();
      newDay = Map.from(widget.oldDay);
   }

   @override Widget build(BuildContext context) {
      return SlikkerScaffold(
         header: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SlikkerCard(
               padding: EdgeInsets.all(10),
               isFloating: true,
               child: Row(
                  children: [
                     Container(width: 10),
                     Text('When your day starts?', style: TextStyle(
                        fontSize: 17, 
                        color: HSVColor.fromAHSV(1, widget.accent, 0.4, 0.4).toColor()
                     )),
                     Expanded(child: Container()),
                     SlikkerCard(
                        accent: 240,
                        onTap: () => showTimePicker(
                           initialTime: TimeOfDay.now(),
                           context: context,
                        ).then((time) => setState(() => newDay['wakeup'] = time)),
                        isFloating: false,
                        borderRadius: BorderRadius.circular(8),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Text(newDay['wakeup']?.format(context) ?? 'Tap!', style: TextStyle(
                           fontSize: 15, 
                           color: HSVColor.fromAHSV(newDay['wakeup'] != null ? 1 : 0.5, widget.accent, 0.4, 0.4).toColor()
                        )),
                     ),
                  ],
               ),
            )
         ),
         content: newDay['wakeup'] == null ? SlikkerCard(
            accent: 240,
            isFloating: false,
            child: Padding(
               padding: EdgeInsets.all(20),
               child: Text('To continue setuping your day, enter time when you wake up.', style: TextStyle(
                  fontSize: 16, 
                  color: HSVColor.fromAHSV(0.7, widget.accent, 0.4, 0.4).toColor()
               ))
            ),
         ) : Column(
            children: [
               for (int i = 0; i <= newDay['projects'].length; i++) Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                           padding: EdgeInsets.all(2),
                           child: Text(i != newDay['projects'].length 
                              ? newDay['projects'][i]['start'].format(context) 
                              : 'later'
                           ),
                        )
                     ),
                     Container(width: 20,),
                     Expanded(
                        child: i != newDay['projects'].length ? SlikkerCard(
                           accent: 240,
                           isFloating: false,
                           padding: EdgeInsets.all(15),
                           child: Text(newDay['projects'][i]['title']),
                        ) : SlikkerCard(
                           accent: 240,
                           isFloating: false,
                           padding: EdgeInsets.all(15),
                           child: SizedBox(
                              height: 50,
                              child: Row(
                                 children: [
                                    Icon(Icons.add_rounded),
                                    Container(width: 20),
                                    Flexible(
                                       child: Text('What you gonna do at this time?')
                                    )
                                 ]
                              ),
                           )
                        )
                     )
                  ]
               )
            ]
         ),
         title: 'Editor',
         topButtonTitle: 'Back',
         topButtonIcon: Icons.arrow_back,
         topButtonAction: () => Navigator.pop(context),
      );
   }
}