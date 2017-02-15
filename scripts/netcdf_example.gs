***********************************************************
* Sample grads script to open, process and plot netcdf    *
*                                                         *
*                                                         *
* Author:                                                 *
*     Emilio Gozo <emil.gozo@gmail.com>                   *
*                                                         *
*                                                         *
* Changelog:                                              *
*     15/02/2017  - File created                          *
***********************************************************

** load the data **
** use sdfopen to read netcdf **
'sdfopen input/trmm/WP262012_BOPHA.nc'

** set variables **
start_date=0z27Nov2012
end_date=0z28Nov2012
lon1=110
lon2=140
lat1=0
lat2=30

** set lat lon box **
'set lon 'lon1' 'lon2
'set lat 'lat1' 'lat2

** set options **
'set mpdset hires'
'set grid off'
'set display color white'
'c'


** get 1 day accumulated rainfall **
'define precip=sum(r*3,time='start_date',time='end_date')-1.5*(r(time='start_date')+r(time='end_date'))'

** set color map **
'color -kind white->blue 0 80 10'

** display the computed value **
'd precip'

** show color bar **
'cbarn'

** add title **
'draw title Rainfall[mm] Nov 27'

** save map as png **
'printim img/rain_nov27.png'

** close grads **
'quit'
