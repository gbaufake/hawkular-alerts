# Show Metrics
TestCase.create(:parameters =>
{:name => "Show Metric", :ssl => false, :hawkular_environment => "http://localhost:8080/",
:hawkular_endpoint => "hawkular/metrics/gauges/data_x/raw?start=0", :http_method => "GET" },
:headers => {:hawkular_tenant => "hawkular" , :content_type => "application/json" } ,
:user => "jdoe", :password => "password")

# List Triggers
TestCase.create(:parameters =>
{:name => "List Triggers", :ssl => false, :hawkular_environment => "http://localhost:8080/",
:hawkular_endpoint => "hawkular/alerts/export", :http_method => "GET" },
:headers => {:hawkular_tenant => "hawkular" , :content_type => "application/json" } ,
:user => "jdoe", :password => "password")

# List alerts
TestCase.create(:parameters =>
{:name => "List Alerts", :ssl => false, :hawkular_environment => "http://localhost:8080/",
:hawkular_endpoint => "hawkular/alerts", :http_method => "GET" },
:headers => {:hawkular_tenant => "hawkular" , :content_type => "application/json" } ,
:user => "jdoe", :password => "password")

# Push Fire Metric
TestCase.create(:parameters =>
{:name => "Push Fire Metrics", :ssl => false, :hawkular_environment => "http://localhost:8080/",
:hawkular_endpoint => "hawkular/metrics/gauges/data_x/raw", :http_method => "POST" },
:headers => {:hawkular_tenant => "hawkular" , :content_type => "application/json" } ,
:user => "jdoe", :password => "password")


# Push Triggers
TestCase.create(:parameters =>
{:name => "Push Triggers", :ssl => false, :hawkular_environment => "http://localhost:8080/",
:hawkular_endpoint => "hawkular/alerts/import/all", :http_method => "POST" },
:headers => {:hawkular_tenant => "hawkular" , :content_type => "application/json" } ,
:user => "jdoe", :password => "password")




# Delete Triggers
