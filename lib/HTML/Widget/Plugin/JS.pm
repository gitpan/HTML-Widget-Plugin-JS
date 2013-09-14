use strict;
use warnings;
package HTML::Widget::Plugin::JS;
{
  $HTML::Widget::Plugin::JS::VERSION = '0.004';
}
use parent qw(HTML::Widget::Plugin);
# ABSTRACT: a JavaScript variable declaration emitter

use Data::JavaScript::Anon;

sub provided_widgets { qw(js_var js_vars js_anon) }

sub boolean_args {}
sub attribute_args {}


sub js_vars {
  my ($self, $factory, $arg) = @_;

  my $str =
    join "\n",
    map  { Data::JavaScript::Anon->var_dump($_ => $arg->{$_}) }
    keys %$arg;

  return $str;
}

BEGIN { *js_var = \&js_vars }


sub js_anon {
  my ($self, $factory, $arg) = @_;

  Data::JavaScript::Anon->anon_dump($arg);
}

1;

__END__

=pod

=head1 NAME

HTML::Widget::Plugin::JS - a JavaScript variable declaration emitter

=head1 VERSION

version 0.004

=head2 js_var

=head2 js_vars

These are two names for the same widget.  Given a hashref, they will produce
JavaScript code to assign the data in the hashref.

In otherwords, this widget:

  $fac->js_vars({
    foo => { a => 1, b => 2 },
    bar => [ 4, 2, 3 ],
  });

...will be rendered something like this:

  var foo = { a: 1, b: 2 };
  var bar = [ 1, 2, 3 ];

=head2 js_anon

This widget converts a given data structure to an anonymous JavaScript
structure.  This basically just provides a widget factory interface to
Data::JavaScript::Anon.

=head1 AUTHOR

Ricardo SIGNES

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by Ricardo SIGNES.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
