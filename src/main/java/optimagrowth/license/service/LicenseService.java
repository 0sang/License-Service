package optimagrowth.license.service;

import lombok.RequiredArgsConstructor;
import optimagrowth.license.model.License;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.Locale;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class LicenseService {

    private final MessageSource messages;

    public License getLicense(String licenseId, String organizationId){
        License license = new License();
        license.setId(new Random().nextInt(1000));
        license.setLicenseId(licenseId);
        license.setOrganizationId(organizationId);
        license.setDescription("Software product");
        license.setProductName("Ostock");
        license.setLicenseType("full");

        return license;
    }

    public String createLicense(License license, String organizationId, Locale locale){
        String responseMessage = null;
        if(!StringUtils.isEmpty(license)) {
            license.setOrganizationId(organizationId);
            responseMessage = String.format(messages.getMessage("license.create.message",null,locale), license.toString());
        }

        return responseMessage;
    }

    public String updateLicense(License license, String organizationId){
        String responseMessage = null;
        if(!StringUtils.isEmpty(license)) {
            license.setOrganizationId(organizationId);
            responseMessage = String.format(messages.getMessage("license.update.message", null, null), license.toString());
        }

        return responseMessage;
    }

    public String deleteLicense(String licenseId, String organizationId){
        String responseMessage = null;
        responseMessage = String.format(messages.getMessage("license.delete.message", null, null),licenseId, organizationId);
        return responseMessage;

    }
}
