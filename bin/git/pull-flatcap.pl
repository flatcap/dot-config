#!/usr/bin/perl

use strict;
use warnings;

our $VERSION = 0.1;

use Data::Dumper;
use LWP::Simple;
use JSON qw(decode_json);

my $url = 'https://api.github.com/users/flatcap/repos';

chdir ("/var/lib/gitolite3/repositories/github/flatcap") or die "$!";

my $json = get ($url);

my $decoded_json = decode_json ($json);

# print Dumper $decoded_json;

foreach (@{$decoded_json}) {
	my $repo = $_;

	my $name = $repo->{'name'};
	my $desc = $repo->{'description'};

	if (defined $desc) {
		$desc =~ tr/\x20-\x7f//cd;
		$desc =~ s/^:[a-z]+:/ /g;
		$desc =~ s/^\s+//;
	} else {
		$desc = '[NONE]';
	}

	printf "%s %s\n", $name, $desc;

	my $dir = $name . '.git';
	if (!-d $dir) {
		my @clone = ('git', 'clone', '--bare', $repo->{'html_url'}, $dir);
		system(@clone) == 0 || die 'git clone failed';

		my $FH;
		my $file;

		$file = $dir . '/description';
		if (!open $FH, '>', $file) {
			die "Can't create file: '$file'\n";
		}

		if (!print {$FH} $desc) {
			printf "Write failed for: %s\n", $file;
		}

		if (!close $FH) {
			printf "Close failed for: %s\n", $file;
		}

		$file = $dir . '/config';
		my $data = "\tfetch = +refs/heads/*:refs/remotes/origin/*\n[gitweb]\n\towner = Richard Russon\n";
		if (!open $FH, '>>', $file) {
			die "Can't create file: '$file'\n";
		}

		if (!print {$FH} $data) {
			printf "Write failed for: %s\n", $file;
		}

		if (!close $FH) {
			printf "Close failed for: %s\n", $file;
		}
	}
}

