// server.test.js
const request = require('supertest');
const { app, server } = require('./server'); // Destructure to get both app and server

describe('GET Endpoints', () => {
  afterAll(() => {
    server.close(); // Close the server after all tests
  });

  it('GET / should return Hello World message', async () => {
    const response = await request(app).get('/');
    expect(response.statusCode).toEqual(200);
    expect(response.text).toContain('Hello, World');
  });

  it('GET /date should return the current date', async () => {
    const response = await request(app).get('/date');
    expect(response.statusCode).toEqual(200);
    expect(response.text).toContain('Current Date and Time');
  });
});
