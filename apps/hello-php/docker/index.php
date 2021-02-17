<?php
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;

require __DIR__ . '/vendor/autoload.php';

$app = AppFactory::create();

if ( getenv('HELLO_MESSAGE') ) {
  $app->hello_message = getenv('HELLO_MESSAGE');
} else {
  $app->hello_message = '<h1>Hello world!</h1>';
}

$app->get('/', function (Request $request, Response $response, $args) use ($app) {
    $response->getBody()->write($app->hello_message);
    return $response;
});
$app->get('/health', function (Request $request, Response $response, $args) {
  return $response->withStatus(200);
});
$app->run();

