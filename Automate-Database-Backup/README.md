This project sets up a scheduled workflow to back up a MongoDB database every 24 hours and upload the backup to Cloudflare R2, which offers a free tier for storage. Additionally, a script is included to restore the database from the latest backup stored in R2.