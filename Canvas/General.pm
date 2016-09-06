package Canvas::General;
$VERSION = v0.0.1;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(submitRequest submitVerbose);

# +-----------+-----------------------------------------------------
# | Libraries |
# +-----------+

use warnings;
use strict;
use LWP::UserAgent;
use HTTP::Request::Common;
use Canvas::Setup;

# +-------+---------------------------------------------------------
# | Setup |
# +-------+

my $ua = LWP::UserAgent->new;
my $VERBOSE = "";

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
  if ($VERBOSE) {
    print STDERR $req->as_string;
  }

  # Submit the request and get the response
  my $resp = $ua->request($req);
  # Report/return the results
  if ($resp->is_success) {
    my $message = $resp->decoded_content;
    if ($VERBOSE) {
      print STDERR "Received reply: [$message]\n";
    }
    my $id = "";
    if ($message =~ m/"$field":"(.*?)"/) {
      $id = $1;
    }
    elsif ($message =~ m/"$field":([0-9]*)/) {
      $id = $1;
    }
    if ($VERBOSE) {
      print STDERR "Id is [$id]\n";
    }
    return $id;
  }
  else {
    print STDERR "HTTP error code: [", $resp->code, "]\n";
    print STDERR "HTTP error message: [", $resp->message, "]\n";
    return "";
  }
} # submitRequest

sub submitVerbose() {
  $VERBOSE = 1;
}

# +---------+-------------------------------------------------------
# | Cleanup |
# +---------+

1;
