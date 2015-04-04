package DDG::Goodie::Duckfoot;
# ABSTRACT: Beginnings of an IF Engine

use DDG::Goodie;

zci answer_type => "duckfoot";
zci is_cached   => 1;

# Metadata.  See https://duck.co/duckduckhack/metadata for help in filling out this section.
name "Duckfoot";
description "An Interactive Fiction Engine, enter all commands upfront";
primary_example_queries "duckfoot north;east;look;west";
# Uncomment and complete: https://duck.co/duckduckhack/metadata#category
# category "";
# Uncomment and complete: https://duck.co/duckduckhack/metadata#topics
# topics "";
code_url "https://github.com/duckduckgo/zeroclickinfo-goodies/blob/master/lib/DDG/Goodie/Duckfoot.pm";
attribution github => ["GitHubAccount", "pgunn"],
            twitter => "dachte";

# Triggers
triggers start => "duckfoot";

sub handle_cmd
{
my ($cmd, $context) = @_;
return "Command received by handle_cmd()"
}

# Handle statement
handle remainder => sub {

    # optional - regex guard
    # return unless qr/^\w+/;

    return unless $_; # Guard against "no answer"

    my %context;
    my $htmlret = '';
    my $textret = '';

    my @parts = split(/;/, $_);
    foreach my $cmd (@parts)
        {
        $textret .= "Command: $cmd";
        $htmlret .= "<div>Command: " . html_enc($cmd) . "</div>";
        my $res = handle_cmd($cmd, \%context);
        $textret .= " Result: $res ";
        $htmlret .= "<div>Result: $res</div>";
        }
    return answer => $textret,
           html   => $htmlret;
};

1;
