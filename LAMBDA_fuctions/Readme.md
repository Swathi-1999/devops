# Invoke Lambda function using API


This POC illustrates how to invoke the lambda function using the API Gateway.

**1.	Steps to create a Simple lambda function.**

  i)	Create a lambda role using below command

    $ aws iam create-role --role-name lambda-ex --assume-role-policy-document '{"Version": "2012-10-17","Statement": [{ "Effect": "Allow", "Principal": {"Service": "lambda.amazonaws.com"}, "Action": "sts:AssumeRole"}]}'
    
 ii)	Add basic execution permission to the role 

    $ aws iam attach-role-policy --role-name lambda-ex --policy-arn arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
    
 iii)	Create an index.js file with below code and save the file

    exports.handler = async (event) => {
        // TODO implement
        const response = {
            statusCode: 200,
            body: JSON.stringify('Hello, this is From lambda function'),
        };
        return response;
    };
    
 iv)	Zip the index.js file into function.zip file

    $ zip function.zip index.js
    
 v)	Create a lambda function and deploy the sample code using the below command

    $ aws lambda create-function --function-name my-function \
    --zip-file fileb://function.zip --handler index.handler --runtime nodejs12.x \
    --role arn:aws:iam::951939890788:role/lambda-ex
    
**2.	Perform following steps to create API**

 i)	Create an API using the following command

    $ aws apigateway create-rest-api --name 'sampleAPI' --description 'This is my first API'
    
 ii)	Get parent resource ID 

    $ aws apigateway get-resources --rest-api-id a2a7463zwa
    
 iii)	Create a resource  

    $ aws apigateway create-resource --rest-api-id a2a7463zwa --parent-id 6twvahph9c --path-part 'new-resource'
    
 iv)	Create a GET method to invoke the lambda function

    $ aws apigateway put-method --rest-api-id a2a7463zwa --resource-id dzx0a0 --http-method GET --authorization-type "NONE" --no-api-key-required --request-parameters "method.request.header.custom-header=false"
    
 v)	Configure the method to invoke lambda function using AWS console
 
   ![Alt text](https://github.com/Protontech-1803/devops/blob/master/LAMBDA_fuctions/Config.png)
    
 
 vi)	Test the API and invoke the lambda function from AWS Console.
 
   ![Alt text](https://github.com/Protontech-1803/devops/blob/master/LAMBDA_fuctions/test_API.png)
    

 


