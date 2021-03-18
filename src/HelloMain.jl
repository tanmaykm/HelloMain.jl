module HelloMain

using HTTP

function serve()
    HTTP.serve("0.0.0.0", 8080) do request::HTTP.Request
        user = HTTP.header(request, "X-User")
        user_email = HTTP.header(request, "X-User-Email")

        @info("request", request, user=HTTP.header(request, "X-User"), user_email=HTTP.header(request, "X-User-Email"))

        try
            login_details = isempty(user_email) ? "not logged in" : "logged in as $user ($user_email)"
            return HTTP.Response("Hello from JuliaHub. You are $login_details.")
        catch e
            return HTTP.Response(404, "Error: $e")
        end
    end
end

end # module
