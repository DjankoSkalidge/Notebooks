use hltv;

drop table if exists picks;
drop table if exists bans;
drop table if exists results;
drop table if exists team;
drop table if exists tournament;
drop table if exists map;



create table Team (
teamname varchar(100) not null,
teamcode int not null,
logo varchar(255),
constraint pkTeam primary key(teamname)
);

create table Tournament (
eventID int not null,
eventName varchar(255) not null,
prizePool int,
location varchar(255) not null,
nteam int,
type varchar(50) not null,
constraint pkTournaments primary key (eventID)
);

create table Map(
map varchar(20) not null,
constraint pkMap primary key (map)
);

create table Results (
matchcode int not null,
team1 varchar(100) not null,
score1 int not null,
score2 int not null,
team2 varchar(100) not null,
firsthalfteam1 varchar(3) not null,
date varchar(50) not null,
time varchar(10) not null,
map varchar(20) not null,
statslink varchar(100), 
event int not null,
constraint pkResults primary key (matchcode, map),
constraint fkTeam1 foreign key (team1) references Team(teamname),
constraint fkTeam2 foreign key (team2) references Team(teamname),
constraint fkEvent foreign key (event) references Tournament(eventID),
constraint fkMap foreign key (map) references Map(map)
);

create table Picks (
team varchar(100) not null,
opponent varchar(100) not null,
matchcode int not null,
pick varchar(20) not null,
priority int not null,
constraint pkPicks primary key (matchcode, team, pick),
constraint fkMappick foreign key (pick) references Map(map),
constraint fkMatchcodePick foreign key (matchcode) references Results(matchcode),
constraint fkTeamPick foreign key (team) references Team(teamname),
constraint fkOpponentPick foreign key (opponent) references Team(teamname)

);

create table Bans (
team varchar(100) not null,
opponent varchar(100) not null,
matchcode int not null,
ban varchar(20) not null,
priority int not null,
constraint pkBans primary key (matchcode, team, ban),
constraint fkMapban foreign key (ban) references Map(map),
constraint fkMatchcodeBan foreign key (matchcode) references Results(matchcode),
constraint fkTeamBan foreign key (team) references Team(teamname),
constraint fkOpponentBan foreign key (opponent) references Team(teamname)
);




