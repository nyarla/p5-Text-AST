package Text::AST::Builder;

use strict;
use warnings;

use Exporter 'import';

use Text::AST::Point;

our @EXPORT_OK = qw[
  point
];

=encoding utf-8

=head1 NAME

Text::AST::Builder - The builder DSL for Text::AST

=head1 SYNOPSIS

    use Text::AST::Builder;

    my $start = point 0, 0;
    my $end = point 10, 0;

=head1 DESCRIPTION

This modules provides domain-specific language for Text::AST.

The all dsl functions exports by default.

=head2 point $x, $y

Make to a L<Text::AST::Point> object.

    # DSL
    my $point = point $x, $y;
    
    # Same as
    my $point = Text::AST::Point->new(
      column => $x,
      line   => $y,
    );

=cut

sub point : prototype($$) {
  my $x = shift;
  my $y = shift;

  return Text::AST::Point->new(
    column => $x,
    line   => $y,
  );
}

1;

=head1 AUTHOR

OKAMURA Naoki aka nyarla / kalaclista <nyarla@kalaclista.com>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
