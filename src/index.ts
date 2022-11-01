//import * as U from './util'
const { Command } = require('commander');
const program = new Command();

const parseTorrent = require('parse-torrent')
const createTorrent = require('create-torrent')
const util = require('util')

program
  .name('captaindirgo-daemon')
  .description('A daemon peer on the captain dirgo network')
  .option('-t,--testing <string>', 'use testing network with given name')
  .version(process.env.npm_package_version);

program.command('create-magnetlink')
  .description('Creates a magnetlink for connection to a captaindirgo network')
  .action((str : string, options : any) => {
      const globalOpts = program.opts()
      makeMagnet(globalOpts.testing ? globalOpts.testing : 'main');
    });

program.command('start')
  .description('Starts the daemon')
  .option('-r,--tracker(s) <string>', 'comma separated list of bittorrent style trackers')
  .option('-a,--address  <string>', '<address> to listen to','0:0:0:-1')
  .option('-e,--extaddressport <string>', '<ip address:port> to report to network')
  .action((str : string, command : any) => {
    const globalOpts = program.opts()
    start(globalOpts,command.opts());
  });

program.parse();

async function makeTorrent(name : string) {
    var data = Buffer.from(`captaindirgo:${name}`)
    console.log(`data is ${data}`)
    
    return await util.promisify(createTorrent)(data)
}

async function makeMagnet(name : string) {
    var t = await makeTorrent(name);
    console.log(`t is ${t}`)
    process.stdout.write(parseTorrent.toMagnetURI(t));
}

async function start(globalOpts : any, opts : any) {
  var Client = require('bittorrent-tracker')
  
  //TODO 2 support uPnP, how are we going to test this? We need to make a uPnP device.

}


