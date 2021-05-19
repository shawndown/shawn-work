const {
    Builder,
    By,
    Key,
    until
} = require('selenium-webdriver');
const {
    DriverService
} = require('selenium-webdriver/remote');

const tabletojson = require('tabletojson').Tabletojson;

var path = require('path');

const jsonfile = require('jsonfile');
 
(async function example() {

    let driver = await new Builder().forBrowser('chrome').build();
    try {
        await driver.get('https://my.unisa.edu.au/student/portal/');
        await driver.findElement(By.id('userNameInput')).sendKeys('yuexy003')
        await driver.findElement(By.id('passwordInput')).sendKeys('Yue5320456', Key.RETURN)
        await driver.findElement(By.id('idSIButton9')).sendKeys(Key.RETURN)

        await driver.get('https://my.unisa.edu.au/Student/Portal/myStudies/Study.aspx')

        await driver.findElement(By.id('ctl00_ctl00_ctl00_ctl00_ctl00_wpManager_wpStudentStudies_allProgramPanels_ctl00_currentandprevious_i0_i0_ctl00_ctl04_classTimetableLink')).click()

        await driver.findElement(By.id('ctl00_ctl00_ctl00_ctl00_ctl00_wpManager_wpStudentStudies_allProgramPanels_ctl00_currentandprevious_i0_i0_ctl00_ctl02_classTimetableLink')).click()
        await driver.findElement(By.id('ctl00_ctl00_ctl00_ctl00_ctl00_wpManager_wpStudentStudies_allProgramPanels_ctl00_currentandprevious_i0_i0_ctl00_ctl03_classTimetableLink')).click()

        await driver.close();
        //Loop through until we find a new window handle
        let tabs = [];
        const windows = await driver.getAllWindowHandles();
        windows.forEach(async handle => {
            tabs.push(handle)
        });

        for(let i of tabs)
        {
            await driver.switchTo().window(i);
            let table = await driver.findElement(By.className('ClassTimeTable'));
            
            let html = await table.getAttribute('innerHTML');
            const converted = tabletojson.convert(html);

            jsonfile.writeFile(path.join(__dirname,'/tmp/data'+ i +'.json'), converted, function (err) {
                if (err) console.error(err)
              })
        }


    } finally {

    }
})();


