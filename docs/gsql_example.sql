## Friends example
## Using TG to identify relationships
##  - gsql, REST and pyTiger examples

## Start by creating entities in TG

## Create a PERSON vertex
BEGIN
CREATE VERTEX person (
    PRIMARY_ID name STRING,
    name STRING, age INT,
    gender STRING, state STRING
)
END

## Create EDGEs betwen PERSONs
CREATE UNDIRECTED EDGE friendship (FROM person, TO person, connect_day DATETIME)

## create a graph for these entities
CREATE GRAPH social (person, friendship)

## load some simple data - create a load job
USE GRAPH social
BEGIN
CREATE LOADING JOB load_social FOR GRAPH social {
   DEFINE FILENAME file1="/home/tigergraph/tutorial/3.x/gsql101/person.csv";
   DEFINE FILENAME file2="//home/tigergraph/tutorial/3.x/gsql101/friendship.csv";

   LOAD file1 TO VERTEX person VALUES ($"name", $"name", $"age", $"gender", $"state") USING header="true", separator=",";
   LOAD file2 TO EDGE friendship VALUES ($0, $1, $2) USING header="true", separator=",";
}
END

## run it
RUN LOADING JOB load_social

## run gsql client remotely
alias gsql="java -jar <path>/gsql_client.jar"

## REST API call to discover topology - vertex and edge
#get vertex cardinality
curl -X POST 'http://localhost:9000/builtins/social' -d  '{"function":"stat_vertex_number","type":"*"}'  | jq .
curl -X POST 'http://localhost:9000/builtins/social' -d  '{"function":"stat_edge_number","type":"*"}' | jq .

## get Bob
## curl -X GET "http://localhost:9000/graph/{graph_name}/vertices/{vertex_type}/{vertex_id}"
curl -X GET "http://localhost:9000/graph/social/vertices/person/Bob"


#t edge detail - wo parts
curl -X GET "http://localhost:9000/graph/social/edges/person/Margie/friendship/"

#three parts
curl -X GET "http://localhost:9000/graph/{graph_name}/edges/{source_vertex_type}/{source_vertex_id}/{edge_type}/{target_vertex_type}/{target_vertex_id}"

## all friends of Tom
curl -X GET "http://localhost:9000/graph/social/edges/person/Tom/friendship/" | jq .

## return all young people - via GSQL
BEGIN
SELECT name, age, gender,  state
    FROM person
    WHERE age <= 30
    ORDER BY name, age
END

## hops query - put in file - create a query NOTE - having issues installing queries
USE GRAPH social
CREATE QUERY hello(VERTEX<person> p) {
  Start = {p};
  Result = SELECT tgt
           FROM Start:s-(friendship:e) ->person:tgt;
  PRINT Result;
}

## execute the query
gsql> @hello.gsql

## install
INSTALL QUERY hello

## run it via curl
curl -X GET 'http://127.0.0.1:9000/query/social/hello?p=Bob'
RUN QUERY hello("Tom")

## more interesting vertex
BEGIN
CREATE VERTEX highwayNode (
   PRIMARY_ID name STRING, 
   latitude FLOAT, 
   longitude FLOAT, 
   trafficWeight INT, 
   name STRING, 
   state STRING)
END

## gsql get friends
BEGIN
CREATE QUERY getFriends(STRING p) FOR GRAPH social {
    Result = SELECT tgt
           FROM person:s-(friendship:e)->person:tgt;
    PRINT Result; 
}
END

## creating/installing and running queries
BEGIN
CREATE QUERY hello () FOR GRAPH social 
{
    people = {person.*};
    print "Hello world!!";
}
END

use graph social
BEGIN
CREATE OR REPLACE QUERY helloWorld ()
{
    print "Hello world!!";
}
END

BEGIN
INTERPRET QUERY () FOR GRAPH social
{
    print "Hello world!!";
}
END

CREATE QUERY hello1 (STRING uid) FOR GRAPH social RETURNS (int)
  SYNTAX v2 {
  # declaration statements
  users = {person.*};
  # body statements
  posts = SELECT p
    FROM users:u-(posted)->:p
    WHERE u.id == uid;
  PRINT posts;
  RETURN posts.size();
}   

## python notebook to install query
print(conn.gsql('''
drop query hello
create query hello(vertex<person> p) for graph social{
    
    start = {p};
    tgt = select t from start:s-(friendship:e)-person:t ;
    print tgt;
}
install query hello
'''))


## built in queries
curl -X POST 'http://localhost:9000/builtins/social' -d  '{"function":"stat_vertex_number","type":"*"}'  | jq .

## get endpoints
curl -X GET "http://localhost:9000/endpoints?builtin=true" | jq .
curl -X GET "http://localhost:9000/statistics/social?seconds=60" | jq .

## add Stan to graph
curl -X POST -d '{"vertices":{"person":{"Stan":{"name":{"value":"Stan"}}}}}' "http://localhost:9000/graph/social"

## Auth - get bearer token

## AdminPortal - create secret
## socialSecret = 0bnapjt8m6o7utvo9femnd9pjkn7kg68

## gen token
curl -X GET -H "Authorization: Bearer 0bnapjt8m6o7utvo9femnd9pjkn7kg68" 'https://localhost:9000'

## sub-domain
se-python-demo

gadmin

gadmin license status
gadmin log ## log locations


docker run -d -p 14022:22 -p 9000:9000 -p 14240:14240 --name tigergraph --ulimit nofile=1000000:1000000 -v ~/data:/home/tigergraph/mydata -t docker.tigergraph.com/tigergraph:latest

