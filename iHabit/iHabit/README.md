//
//  README.md
//  iHabit
//
//  Created by Tiago Camargo Maciel dos Santos on 03/06/25.
//



Screen requirements:
- Main Screen, which shows all of the habits;
- Habit Creation Screen, which allows the user to create a new habit (sheet);
- Habit Details Screen, which shows the details of a specific habit - including:
    - the number of times the habits was done;
    - edit button;
    - delete button;


Other requirements:
- Store data in UserDefaults;


Data:
- Habit struct
    - title
    - description
    - icon
    - numberOfTimesDone
- HabitsModel class
    - array of Habit
    - function to encode data in UserDefaults
    - function to decode data from UserDefaults
