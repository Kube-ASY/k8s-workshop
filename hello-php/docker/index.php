<?php

use \Slim\Http\Request;
use \Slim\Http\Response;

require __DIR__ . '/vendor/autoload.php';



$app = new \Slim\App();

if ( getenv('HELLO_MESSAGE') ) {
  $app->hello_message = getenv('HELLO_MESSAGE');
} else {
  $app->hello_message = '<h1>Hello world!</h1>';
}

$app->get('/', function (Request $request, Response $response) use ($app) {
    $response->getBody()->write($app->hello_message);
    return $response;
});
$app->get('/health', function (Request $request, Response $response) {
    return $response->withStatus(200);
});
$app->run();
