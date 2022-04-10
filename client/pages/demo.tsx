import Link from 'next/link';
import { Button } from '@mantine/core';

function Demo() {
  return (
    <Link href="/hello" passHref>
      <Button component="a">Next link button</Button>
    </Link>
  );
}
export default Demo;