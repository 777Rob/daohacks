
import {HookTOGetNfts} from "../GraphQL/Hooks"
import { AppProps } from 'next/app';
import Head from 'next/head';
import { MantineProvider } from '@mantine/core';
import Demo from "./demo";
import {Typography, Box} from "@mui/core";
import { Grid } from '@mantine/core';
import { ethers } from "ethers";
import Web3Modal from "web3modal";



const providerOptions = {
  /* See Provider Options Section */
};

const web3Modal = new Web3Modal({
  network: "rinkeby", // optional
  cacheProvider: true, // optional
  providerOptions // required
});

const instance = await web3Modal.connect();

const provider = new ethers.providers.Web3Provider(process.env.ALCHEMY_API_KEY);
const signer = provider.getSigner();

function App() {


  return (<MantineProvider
    withGlobalStyles
    withNormalizeCSS
    theme={{
      
          colorScheme: 'light',
        }}
        >
      <Head>
        <title>The Club</title>
        <meta name="viewport" content="minimum-scale=1, initial-scale=1, width=device-width" />
      </Head>

<Typography>
  
Welcome to the automatically generated NFT communities that provide even more utility for NFT token holders!
By building on smart contracts, we are able to provide a more seamless experience for our users. As a result,
 people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community
  of that token for free. This allows them to interact with other members, receive updates about the community, and
   participate in its governance. We hope that you take advantage of this platform and use it to grow your community
    and create value for all of its members. Thank you for being here!
</Typography>
      </MantineProvider>
    
  );
}

// Welcome to the automatically generated NFT communities that provide even more utility for NFT token holders! By building on smart contracts, we are able to provide a more seamless experience for our users. As a result, people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community of that token for free. This allows them to interact with other members, receive updates about the community, and participate in its governance. We hope that you take advantage of this platform and use it to grow your community and create value for all of its members. Thank you for being here! Write why NFT communities are worth to participate in. 

// NFT communities are worth participating in because they provide a more seamless experience for their users. By building on smart contracts, NFT communities are able to provide a more seamless experience for their users. As a result, people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community of that token for free. This allows them to interact with other members, receive updates about the community, and participate in its governance. We hope that you take advantage of this platform and use it to grow your community and create value for all of its members. Thank you for being here!

// Write why decentralized governance is the future.

// Decentralized governance is the future because it allows for a more democratic and transparent way of governing communities. By building on smart contracts, decentralized governance is able to provide a more seamless experience for their users. As a result, people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community of that token for free. This allows them to interact with other members, receive updates about the community, and participate in its governance. We hope that you take advantage of this platform and use it to grow your community and create value for all of its members. Thank you for being here!

// Write that there is a community for anyone based on their interests.

// There is a community for anyone based on their interests. No matter what your interests are, there is sure to be an NFT community that you can join and participate in. By building on smart contracts, these communities are able to provide a more seamless experience for their users. As a result, people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community of that token for free. This allows them to interact with other members, receive updates about the community, and participate in its governance. We hope that you take advantage of this platform and use it to grow your community and create value for all of its members. Thank you for being here!

// Some communities are created just for fun but some of them facilitate effective collaboration of huge groups of people ,because governance mechanisms are made the way that they are fair , transparent and it is interest of all participating members to make it work well.

// It is worth to participate in NFT communities, because they provide a more seamless experience for their users. By building on smart contracts, NFT communities are able to provide a more seamless experience for their users. As a result, people who own the most popular NFTs, like ERC721 and ERC1151, are automatically eligible to join the community of that token for free. This allows them to interact with other members, receive updates about the community, and participate in its governance. We hope that you take advantage of this platform and use it to grow your community and create value for all of its members. Thank you for being here!