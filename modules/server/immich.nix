{ config, ... }:
{
  homelab.ports = [ config.services.immich.port ];
  services.immich = {
    enable = true;
    settings = {
      backup = {
        database = {
          cronExpression = "0 02 * * *";
          enabled = true;
          keepLastAmount = 14;
        };
      };
      job = {
        backgroundTask.concurrency = 5;
        editor.concurrency = 2;
        faceDetection.concurrency = 2;
        library.concurrency = 5;
        metadataExtraction.concurrency = 5;
        migration.concurrency = 5;
        notifications.concurrency = 5;
        ocr.concurrency = 1;
        search.concurrency = 5;
        sidecar.concurrency = 5;
        smartSearch.concurrency = 2;
        thumbnailGeneration.concurrency = 3;
        videoConversion.concurrency = 1;
        workflow.concurrency = 5;
      };
      logging = {
        enabled = true;
        level = "log";
      };
      machineLearning = {
        availabilityChecks = {
          enabled = true;
          interval = 30000;
          timeout = 2000;
        };
        clip = {
          enabled = true;
          modelName = "ViT-B-32__openai";
        };
        duplicateDetection = {
          enabled = true;
          maxDistance = 0.01;
        };
        enabled = true;
        facialRecognition = {
          enabled = true;
          maxDistance = 0.5;
          minFaces = 5;
          minScore = 0.7;
          modelName = "buffalo_l";
        };
      };
      metadata = {
        faces = {
          import = true;
        };
      };
      newVersionCheck = {
        enabled = false;
      };
      nightlyTasks = {
        clusterNewFaces = true;
        databaseCleanup = true;
        generateMemories = true;
        missingThumbnails = true;
        startTime = "00:00";
        syncQuotaUsage = true;
      };
      server = {
        externalDomain = "https://immich.v3nco.dev";
        publicUsers = true;
      };
      storageTemplate = {
        enabled = true;
        hashVerificationEnabled = true;
        template = "{{y}}/{{y}}-{{MM}}-{{dd}}/{{filename}}";
      };
      trash = {
        days = 30;
        enabled = true;
      };
      user = {
        deleteDelay = 7;
      };
    };
  };
}
