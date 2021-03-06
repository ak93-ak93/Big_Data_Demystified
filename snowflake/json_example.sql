create or replace stage MYS3STAGE2_json 
url='s3://omid-test/json/' 
CREDENTIALS=(aws_key_id='AW' aws_secret_key='/ml6y') ;

with data as(
select $1 as v   from @MYS3STAGE2_json  (file_format => MY_JSON_FILE_FORMAT) limit 10
) 

select *, f.key,f.path  from data a, lateral flatten(input=> a.v , recursive =>true) f  ;
