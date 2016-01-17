var express = require('express');
var bodyParser = require('body-parser');

// Initialize app by using Express framework.
var app = express();

// Use Body Parser (Helps to process incoming requests).
app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

// Set default port 1337 or custom if defined by user externally.
app.set('port', process.env.PORT || 1337);

// Initialization of books array.
var books = [
  {
    id: 1,
    name: "Differential Equations And Linear Algebra",
    course: "MATH 211",
    ISBNNumber: "9780130457943",
    image: "",
    condition: "Likely New",
    price: 40,
    seller: "Bob Zhang"
  },
  { 
    id: 2,
    name: "Discrete Mathematics and Its Applications",
    course: "COMP 182",
    ISBNNumber: "9780073383095",
    image: "",
    condition: "New",
    price: 50,
    seller: "Richard He"
  },
  { 
    id: 3,
    name: "Music in Theory and Practice",
    course: "MUSI 117",
    ISBNNumber: "9780077493318",
    image: "",
    condition: "Moderate",
    price: 30,
    seller: "Yisong Qin"
  }
]; 

// A simulation of creating new IDs. Basically get the last element and increase the value of an ID. 
function getNewId(){
  return books[books.length -1].id + 1;
}

// Function findIndexOfElement helps to identify the array index according to specified key/value pair. 
function findIndexOfElement(inputArray, key, value){
  for (var i = 0; i < inputArray.length; i++){
    if (inputArray[i][key] === value){
      return i;
    }
  }
  return -1;
}

// GET - list of all records.
app.get('/api/books', function(request, response){
  response.json(books.map(function(book){
    return {
      id: book.id,
      name: book.name,
      course: book.course,
      ISBNNumber: book.ISBN,
      image: book.image,
      condition: book.condition,
      price: book.price,
      seller: book.seller
    }
  }));
});

// GET - list of a record with particular id. If not found, forward the request to 404 - not found. 
app.get('/api/books/:id', function(request, response, next){  
  // Get an integer interpretation of URL parameter. 
  var urlIntParam = parseInt(request.params.id);
  // Check whether the element is a valid positive number. If not (following case, redirect the request to 404).
  if (urlIntParam < 0 || isNaN(urlIntParam)){
    // Use following middleware - matched 404.
    next();
  }
  else {
    // Find array index in our book array based on the input parameter (converted to integer). 
    var elementIndex = findIndexOfElement(books, 'id', urlIntParam);
    // If element exists, get the response, otherwise redirect to 404.
    if (elementIndex >= 0){
      // Get an object from book array.
      var selectedBook = books[elementIndex];
      // Return JSON response with selected attributes.
      response.json({
        id: selectedBook.id,
        name: selectedBook.name,
        course: selectedBook.course,
        ISBNNumber: selectedBook.ISBN,
        image: selectedBook.image,
        condition: selectedBook.condition,
        price: selectedBook.price,
        seller: selectedBook.seller
      });
    }
    else
    {
      // redirection to 404.
      next();      
    }
  }
});

// POST - create a new element.
app.post('/api/books', function(request, response){
  // Complete request body.
  var requestBody = request.body;
  
  books.push({
    id: requestBody.id,
    name: requestBody.name,
    course: requestBody.course,
    ISBNNumber: requestBody.ISBN,
    image: requestBody.image,
    condition: requestBody.condition,
    price: requestBody.price,
    seller: requestBody.seller
  });
  
  response.status(200).end();
});

// DELETE - remove particular record from array.
app.delete('/api/books/:id', function(request, response, next){
  // Get an integer interpretation of URL parameter. 
  var urlIntParam = parseInt(request.params.id);
  // Check whether the element exists or not (or it is not a number). If not (following case, redirect the request to 404).
  if (urlIntParam < 0 || isNaN(urlIntParam)){
    // Use following middleware - matched 404.
    next();
  }
  else {
    // Find array index in our book array based on the input parameter (converted to integer).
    var elementIndex = findIndexOfElement(books, 'id', urlIntParam);
    // If element exists, get the response, otherwise redirect to 404.
    if (elementIndex >= 0){
      // Delete element according to index parameter.
      books.splice(elementIndex, 1);
      // Element successfuly deleted.
      response.status(200).end();
    }
    else {
      // redirection to 404.
      next();
    }
  }
}); 

// Use Express midleware to handle 404 and 500 error states.
app.use(function(request, response){
   // Set status 404 if none of above routes processed incoming request. 
   response.status(404); 
   // Generate the output.
   response.send('404 - not found');
});

// 500 error handling. This will be handled in case of any internal issue on the host side.
app.use(function(err, request, response){
  // Set response type to application/json.
  response.type('application/json');
  // Set response status to 500 (error code for internal server error).
  response.status(500);
  // Generate the output - an Internal server error message. 
  response.send('500 - internal server error');
});

// Start listening on defined port, this keep running the application until hit Ctrl + C key combination.  
app.listen(app.get('port'), function(){
  console.log("Host is running and listening on http://localhost:" + app.get('port') + '; press Ctrl-C to terminate.');  
});