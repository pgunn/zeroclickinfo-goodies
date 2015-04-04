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

##################
# Data structures that define a world

sub get_fresh_context
{   # Returns a data structure with a fresh "world"
    # and user state
my %ret =
    (
    world       => [],
    inventory   => [],
    flags       => [],
    location    => 1
    );
return %ret;
}



#######
# Command handler, most of the work comes here

sub handle_cmd
{
my ($cmd, $context) = @_;
return "Command received by handle_cmd()"
}


#######
# State/context serialisers/deserialisers
# We define context as the active data structure,
# and state as the serialised (numeric) form of the same

sub load_context_from_state
{
my ($state, $context_r) = @_;
# TODO
}

sub save_context_to_state
{   # Save mutable differences from stock world into a single number form
my %context = @_;
# TODO
my $state = 0;
return $state;
}
#######


# Handle statement
handle remainder => sub {

    # optional - regex guard
    # return unless qr/^\w+/;

    return unless $_; # Guard against "no answer"

    my %context = get_fresh_context();
    my $htmlret = '';
    my $textret = '';

    my @parts = split(/;/, $_);
    if(defined($parts[0]) && ($parts[0] =~ /^\d+/))
        {   # If the user's first search term is a number, we assume it's a number-encoded form of
            # their context, and decode that.
        my $state = shift(@parts);
        load_context_from_state($state, \%context);
        }
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
