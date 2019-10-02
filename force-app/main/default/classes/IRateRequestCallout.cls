/**
 * Interface for making callouts to a third party shipping service.
 * @author Brian Zigarovich
 */
public interface IRateRequestCallout {
    /**
     * Builds the HTTP request for getting shipping rates.
     * @param request the shipping request information
     * @return the HTTP request for the shipping service.
     */
    HttpRequest getRequest(RateRequest request);

    /**
     * Gets the rates from the shipping service.
     * @param response the response from the web service
     * @return the list of shipping rate options from the service.
     */
    List<RateInfo> processRates(HttpResponse response);
}