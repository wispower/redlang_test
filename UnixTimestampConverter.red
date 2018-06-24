Red [Needs: 'View]

convert: func [timestamp] [
    year: timestamp / 10000
    month: (mod timestamp 10000) / 100
    day: mod timestamp 100

    rejoin [year '- month '- day]
]

toUtcTime: func [epoch] [
    epochInteger: to integer! epoch
    formatTime to-date epochInteger
]

toLocalTime: func [epoch] [
    epochInteger: to integer! epoch
    formatTime (to-date epochInteger) + now/zone
]

formatTime: func [date] [
    rejoin [date/year '- date/month '- date/day " " date/time]
]

;;tim: append form  "Current Time: " formatTime now        ;;<-- set tim variable with time
timeStr: formatTime now       ;;<-- set tim variable with time
timeStampStr: append form to-integer now

flags: clear []
       append flags 'modal
       append flags 'popup                          ;;<-- I think popup only works for Windows

view/flags [size 540x130 title "Unix timestamp converter" 
    at 10x10 text "Current Time:" at 100x10 currTime: field 150x20 timeStr 
    at 260x10 text "Current Timestamp:" at 380x10 currTimeStamp: field 150x20 timeStampStr

    at 10x40 text font-size 14 font-color purple "Convert Unitx timestamp to date" return
    at 10x70 timestamp: field 150x20
    at 170x67 button font-color purple 100x20"Convert=>" [
        utcTime/text: toUtcTime timestamp/text
        localTime/text: toLocalTime timestamp/text]
   
    at 255x70 text right "UTC time:" at 350x70 utcTime: field 150x20
    at 255x100 text right "Local time:" at 350x100 localTime: field 150x20

    rate 1 on-time [currTime/text: formatTime now currTimeStamp/text: to string! to-integer now]
]flags


