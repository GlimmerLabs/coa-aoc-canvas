package Canvas::General;
$VERSION = v0.0.1;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(submitRequest);

# +-----------+-----------------------------------------------------
# | Libraries |
# +-----------+

use warnings;
use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use JSON::Parse 'parse_json';
use Canvas::Setup;

# +-------+---------------------------------------------------------
# | Setup |
# +-------+

my $ua = LWP::UserAgent->new;

# +----------+------------------------------------------------------
# | Exported |
# +----------+

# submitRequest($req,[field])
#   Submit a request and return either the id/field of the response
#   (success) or the empty string (failure).
sub submitRequest($;$) {
  my ($req,$field) = @_;
  if (! $field) { $field = "id"; }

  # Add authorization
  addAuthorization($req);

  # For debugging/development
  print STDERR $req->as_string;
  # return 5;

  # Submit the request and get the response
  my $resp = $ua->request($req);
  # Report/return the results
  if ($resp->is_success) {
    my $message = $resp->decoded_content;
    print STDERR "Received reply: [$message]\n";
    my $stuff = parse_json($message);
    my $id = @$stuff{$field};
    print "Id is [$id]\n";
    return "$id";
  }
  else {
    print "HTTP error code: [", $resp->code, "]\n";
    print "HTTP error message: [", $resp->message, "]\n";
    return "";
  }
} # submitRequest

# +---------+-------------------------------------------------------
# | Cleanup |
# +---------+

1;
