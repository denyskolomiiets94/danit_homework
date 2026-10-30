from http.server import BaseHTTPRequestHandler, HTTPServer
import socket


class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/":
            pod_ip = socket.gethostbyname(socket.gethostname())

            self.send_response(200)
            self.send_header("Content-type", "text/plain")
            self.end_headers()

            self.wfile.write(
                f"Hello from Kubernetes! Pod IP: {pod_ip}".encode()
            )
        else:
            self.send_response(404)
            self.end_headers()


server = HTTPServer(("0.0.0.0", 8080), MyHandler)
print("Server is running on port 8080")

server.serve_forever()