const express = require('express')
const app = express()
const port = 3000
const bodyParser = require('body-parser');

const fs = require('fs');
let rawdata = fs.readFileSync('user.json');
let users = JSON.parse(rawdata);

const path = require('path');

const tabletojson = require('tabletojson').Tabletojson;

app.use(bodyParser.urlencoded());
app.use(bodyParser.json());
app.use('/course', express.static(path.join(__dirname, 'public')))

app.get('/scrap', async (req, res) => {

    let page = req.query.page


    var url = 'http://localhost:3000/course/' + page;

    tabletojson.convertUrl(url)
        .then(function (tablesAsJson) {
            res.json({
                "status": "success",
                "data": tablesAsJson[0]
            })

            return;
        })
        .catch(function () {
            res.json({
                "status": "error"
            })
        });



})

app.post('/auth', function (req, res) {
    console.log(req.body)

    let r_user = req.body.user;
    let r_pwd = req.body.password;

    for (user of users) {
        if (user.user === r_user && user.password === r_pwd) {
            res.json({
                status: "success"
            })
            return
        }
    }

    res.json({
        status: "error"
    })
})

app.listen(port, () => {
    console.log(`demo listening at http://localhost:${port}`)
})