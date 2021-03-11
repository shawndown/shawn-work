# UniSA Map Mobile Application Project

## Project Structure

All project-related file will store under this Directory, the basic structure as follows:

- **/src**
  >Source code directory

- **/demo**
  >Mobile App demo snapshot or short video clip for reviewing

- **/ui**
  >UI design files

- **/documents**
  >Project related documents

- **/architecture**
  >Project Architecture design files

## Project Timeline -- update with progress

| Timeline| Task| Status|
| ------------- |:-------------| -----:|
| week 1| Create a project proposal and scope project, please check document project_proposal.pdf | &check;|
| week 2 |Business logic design, including mobile application architecture design and process design. <br><br>For mobile application artchitecture, please use http://diagram.io/ to load the architecture XML file or read ./Architecture/mobile_application_architecture.jpg.<br><br> For process design, please use http://diagram.io/ to load the process XML files or read <br> ./Architecture/login_process.jpg <br> ./Architecture/logout_process.jpg <br> ./Architecture/load_course_process.jpg <br> ./Architecture/load_map_process.jpg <br> ./Architecture/navigation_process.jpg|&check; |
| week 3 |Database structure design|&cross; |
| week 4 |Prototype and UI design|&cross; |
| week 5 |Mobile APP development ( phase 1 * ) |&cross; |
| week 6 |Mobile APP development ( phase 2 * )|&cross; |
| week 7 |Mobile APP development ( phase 3 - Part 1 * )|&cross; |
| week 8 |Mobile APP development ( phase 3 - Part 2 * )|&cross; |
| week 9 |Project review and possibility research ( phase 4 - Part 1 * )|&cross; |
| week 10|Mobile APP development ( phase 4 - Part 2 * )|&cross; |
| week 11|QA testing|&cross; |
| week 12|Project finalize|&cross; |

### Development Phase 1

- Generate source code skeleton for the project
- Create SQLite database models based on previous database design
- Generate Mock data for user login, student course timetable and Map essential information
- Create Login Components and finish the user login part
- Complete the User management part
  
### Development Phase 2

- Test Google API authentication and request
- Test Google Map real-time geolocation API and navigation API
- Create a Campus Map display component 
- Create a Map cover layer to implement Map building highlight functions
- Display build name and related information on the Map
- fetch real-time geolocation and pin on the Map

### Development Phase 3 - Part 1

- Create student course timetable component
- Embed timetable and display the current user's timetable 
- complete interactive functions, such as mark future class and allow the user to tap the class tab to start map navigation.

### Development Phase 3 - Part 2

- Test Google Map navigation function 
- add more interactive feature, such as press building tag to show the details.
- add function to allow the user to show important locations on the map, such as the library, campus central, STEM office or food.

### Development Phase 4 - Part 1

- Apply UI design
- Write Unit Test for each component
- Move to the test-run stage
- Try to find any possible solutions to embed the AR toolkit to show the direction.

### Development Phase 4 - Part 2

- Try to embed AR toolkit to APP
- create 3D arrow models to use
- show the 3D arrow when in the navigation mode; the arrow will guide the users to the destination.