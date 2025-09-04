package Text::AST::Point;

use strict;
use warnings;

use Carp qw(croak);

=encoding utf8

=head1 NAME

Text::AST::Point - the pointer object for AST position.

=head1 SYNOPSIS

    # ($key => $value) style
    my $point = Text::AST::Point->new( line => 10, column => 2 );

    # {$key => $value} style
    my $point = Text::AST::Point->new({ line => 10, column => 2 });

=head1 DESCRIPTION

This class is the pointer object to location in text source.

This class has two properties, these properties are C<line> and C<column>.

=head1 CONSTRUCTOR

=head2 new

    # ($key => $value) style
    my $point = Text::AST::Point->new( line => 0, column => 0 );

    # {$key => $value} style
    my $point = Text::AST::Point->new({ line => 0, column => 0 });

This constructor could be pass to the two style arguments specification.

It's the list of C<$key> and C<$value> pairs,
or HASH reference of same as list pair.

The properties could be specified C<line> or C<column>.

If passed to any others properties, this constructor throws error.

=cut

sub new {
  my $class = shift;

  # The arguments validation.
  # This constructor supports `->new({ $key => $value })` or `->new($key => $val)` style.
  my $args;
  if ( ref $_[0] eq 'HASH' ) {
    $args = $_[0];
  }
  else {
    if ( @_ % 2 == 0 ) {
      $args = {@_};
    }
    else {
      croak "Unsupported arguments. the arguments shoule be HASH reference or key-value pair";
    }
  }

  if ( ( my @unsupported = grep { $_ ne 'line' && $_ ne 'column' } sort keys %{$args} ) != 0 ) {
    croak "The arguments has unsupported property keys: " . join q{, }, @unsupported;
  }

  my $this = {};
  for my $prop (qw/line column/) {
    if ( defined( my $value = delete $args->{$prop} ) ) {
      if ( $value =~ m{[^0-9]} || $value eq q{} ) {
        croak "The argument '${prop}' is not 0 or larger number";
      }

      $this->{$prop} = 0+ $value;
      next;
    }

    croak "The '${prop}' is missing. this argument always required.";
  }

  return bless $this, $class;
}

=head1 PROPERTIES

=head2 line

    # get line number.
    my $line = $point->line;

    # set line number.
    $point->line(0);

The line number of point to location.

This property could be update by pass argument to property method,
but it accept C<0> or larger number.

=cut

sub line {
  my $this = shift;
  return $this->{'line'} if ( @_ == 0 );

  if ( @_ == 1 ) {
    my $value = shift // croak "The argument was passed, but it's maybe undef?";
    if ( $value =~ m{[^0-9]} || $value eq q{} ) {
      croak "The argument should be 0 or larger integer";
    }

    $this->{'line'} = 0+ $value;
  }
  else {
    croak "This property supports 0 or 1 argument.";
  }

  return $this->{'line'};
}

=head2 column

    # get column number.
    my $column = $point->column;

    # set column number.
    $point->column(0);

The column number on line of point to location.

This propery could be update by pass argument to propery method,
but is accpet C<0> or larger number.

=cut

sub column {
  my $this = shift;
  return $this->{'column'} if ( @_ == 0 );

  if ( @_ == 1 ) {
    my $value = shift // croak "The argument was passed, but it's maybe undef?";
    if ( $value =~ m{[^0-9]} || $value eq q{} ) {
      croak "The argument should be 0 or larger integer";
    }

    $this->{'column'} = 0+ $value;
  }
  else {
    croak "This property supports 0 or 1 argument.";
  }

  return $this->{'column'};
}

=head1 AUTHOR

OKAMURA Naoki aka nyarla / kalaclita <nyarla@kalaclista.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
