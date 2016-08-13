package Canvas::Setup;
$VERSION = v0.0.1;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw(addAuthorization canvasURL);

# +-----------+-----------------------------------------------------
# | Libraries |
# +-----------+

use warnings;
use strict;

# +---------+-------------------------------------------------------
# | Globals |
# +---------+

my $COURSE;
my $TOKEN;
my $BASE_URL;

# +-------+---------------------------------------------------------
# | Setup |
# +-------+

open (my $course, "<", ".course") || die "Cannot open file '.course' because $!";
$COURSE = <$course>;
chomp($COURSE);
close($course);

$BASE_URL =  "https://globalonlineacademy.instructure.com/api/v1/courses/$COURSE";

open (my $token, "<", ".token") || die "Cannot open file '.token' because $!";
$TOKEN = <$token>;
chomp($COURSE);
close($token);

# +----------+------------------------------------------------------
# | Exported |
# +----------+

sub addAuthorization($) {
  my ($req) = @_;
  $req->header('authorization' => "Bearer $TOKEN");
}

sub canvasURL($) {
  my ($dir) = @_;
  return "$BASE_URL/$dir";
}

sub courseID() {
  return $COURSE;
}

sub token() {
  return $TOKEN;
}

# +---------+-------------------------------------------------------
# | Cleanup |
# +---------+

1;
